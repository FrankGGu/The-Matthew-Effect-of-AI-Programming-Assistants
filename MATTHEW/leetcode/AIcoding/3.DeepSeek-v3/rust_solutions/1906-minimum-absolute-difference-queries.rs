impl Solution {
    pub fn min_difference(nums: Vec<i32>, queries: Vec<Vec<i32>>) -> Vec<i32> {
        let n = nums.len();
        let mut prefix = vec![[0; 101]; n + 1];

        for i in 0..n {
            for j in 1..=100 {
                prefix[i + 1][j] = prefix[i][j];
            }
            prefix[i + 1][nums[i] as usize] += 1;
        }

        let mut res = Vec::with_capacity(queries.len());
        for q in queries {
            let l = q[0] as usize;
            let r = q[1] as usize;
            let mut prev = -1;
            let mut min_diff = i32::MAX;
            for j in 1..=100 {
                if prefix[r + 1][j] - prefix[l][j] > 0 {
                    if prev != -1 {
                        min_diff = min_diff.min(j as i32 - prev);
                    }
                    prev = j as i32;
                }
            }
            if min_diff == i32::MAX {
                res.push(-1);
            } else {
                res.push(min_diff);
            }
        }
        res
    }
}