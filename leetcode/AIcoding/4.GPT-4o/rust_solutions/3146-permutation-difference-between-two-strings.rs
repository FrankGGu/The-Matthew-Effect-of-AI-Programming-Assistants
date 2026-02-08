impl Solution {
    pub fn minimum_difference(nums1: Vec<i32>, nums2: Vec<i32>) -> i32 {
        let n = nums1.len();
        let sum1: i32 = nums1.iter().sum();
        let sum2: i32 = nums2.iter().sum();

        let mut dp1 = vec![vec![false; (sum1 + sum2 + 1) as usize]; n + 1];
        let mut dp2 = vec![vec![false; (sum1 + sum2 + 1) as usize]; n + 1];

        dp1[0][0] = true;
        for i in 0..n {
            for j in 0..=sum1 {
                dp1[i + 1][j as usize] = dp1[i][j as usize];
                if j >= nums1[i] {
                    dp1[i + 1][j as usize] |= dp1[i][(j - nums1[i]) as usize];
                }
            }
        }

        dp2[0][0] = true;
        for i in 0..n {
            for j in 0..=sum2 {
                dp2[i + 1][j as usize] = dp2[i][j as usize];
                if j >= nums2[i] {
                    dp2[i + 1][j as usize] |= dp2[i][(j - nums2[i]) as usize];
                }
            }
        }

        let total = sum1 + sum2;
        let mut min_diff = total;

        for i in 0..=sum1 {
            if dp1[n][i as usize] {
                for j in 0..=sum2 {
                    if dp2[n][j as usize] {
                        min_diff = min_diff.min((sum1 - i - (sum2 - j)).abs());
                    }
                }
            }
        }

        min_diff
    }
}