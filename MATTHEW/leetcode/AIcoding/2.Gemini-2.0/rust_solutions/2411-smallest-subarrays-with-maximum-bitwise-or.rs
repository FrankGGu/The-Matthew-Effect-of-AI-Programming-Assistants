impl Solution {
    pub fn smallest_subarray_length(nums: Vec<i32>, threshold: i32) -> i32 {
        let n = nums.len();
        let mut ans = 1;
        let mut i = 0;
        while i < n {
            let mut or_val = 0;
            let mut j = i;
            while j < n {
                or_val |= nums[j];
                if or_val > threshold {
                    ans = ans.max((j - i + 1) as i32);
                    break;
                }
                j += 1;
            }
            if j == n && or_val <= threshold {
                return -1;
            }
            i += 1;
        }

        let mut max_bit = 0;
        for &num in &nums {
            for i in 0..32 {
                if (num >> i) & 1 == 1 {
                    max_bit = max_bit.max(i);
                }
            }
        }

        let mut res = n as i32 + 1;
        for i in 0..n {
            if nums[i] > 0 {
                let mut or_val = nums[i];
                let mut j = i + 1;
                while j < n {
                    or_val |= nums[j];
                    if or_val == (1 << (max_bit + 1)) - 1 {
                        res = res.min((j - i + 1) as i32);
                        break;
                    }
                    j += 1;
                }
            }
        }

        if res == n as i32 + 1 {
            return -1;
        }

        res
    }
}

struct Solution;