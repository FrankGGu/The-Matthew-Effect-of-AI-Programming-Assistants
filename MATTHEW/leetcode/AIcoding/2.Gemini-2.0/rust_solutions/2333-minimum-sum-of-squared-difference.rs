impl Solution {
    pub fn min_sum_square_diff(nums1: Vec<i32>, nums2: Vec<i32>, mut k1: i32, mut k2: i32) -> i64 {
        let n = nums1.len();
        let mut diff: Vec<i32> = Vec::with_capacity(n);
        for i in 0..n {
            diff.push((nums1[i] - nums2[i]).abs());
        }

        diff.sort_unstable();

        let mut k = k1 + k2;

        for i in (0..n).rev() {
            if i == 0 {
                let dec = k / (i as i32 + 1);
                k %= (i as i32 + 1);
                for j in 0..=i {
                    diff[j] = (diff[j] - dec).max(0);
                }
                break;
            }

            let delta = diff[i] - diff[i-1];

            if delta * (i as i32 + 1) <= k {
                k -= delta * (i as i32 + 1);
                for j in 0..=i {
                    diff[j] = diff[i-1];
                }
            } else {
                let dec = k / (i as i32 + 1);
                k %= (i as i32 + 1);
                for j in 0..=i {
                    diff[j] = (diff[j] - dec).max(0);
                }
                break;
            }
        }

        let mut ans: i64 = 0;
        for i in 0..n {
            ans += (diff[i] as i64) * (diff[i] as i64);
        }

        ans
    }
}