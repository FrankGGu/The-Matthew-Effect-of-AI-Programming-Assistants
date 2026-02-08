impl Solution {
    pub fn max_sub_array_sum_divisible_by_k(nums: Vec<i32>, k: i32) -> i32 {
        let n = nums.len();
        let k = k as usize;
        let mut prefix_sums = vec![0; k];
        let mut max_sums = vec![-1; k];
        max_sums[0] = 0;
        let mut current_sum = 0;
        let mut max_sum = 0;

        for i in 0..n {
            current_sum = (current_sum + nums[i]) % (k as i32);
            let current_sum_usize = current_sum as usize;
            if current_sum < 0 {
                current_sum_usize = (current_sum + k as i32) as usize;
            }
            if max_sums[current_sum_usize] == -1 {
                max_sums[current_sum_usize] = (i + 1) as i32;
            }
            prefix_sums[current_sum_usize] = i as i32;
        }

        current_sum = 0;
        for i in 0..n {
            current_sum = (current_sum + nums[i]) % (k as i32);
            let current_sum_usize = current_sum as usize;
             if current_sum < 0 {
                current_sum_usize = (current_sum + k as i32) as usize;
            }

            if max_sums[current_sum_usize] > -1 {
                max_sum = max_sum.max((i as i32 - max_sums[current_sum_usize] + 1) as i32);
            }
        }

        let mut total_sum = 0;
        for i in 0..n {
            total_sum += nums[i];
        }

        if total_sum % (k as i32) == 0 {
            max_sum = max_sum.max(n as i32);
        }

        let mut current_sum = 0;
        for i in 0..n {
            current_sum += nums[i];
        }

        if current_sum % (k as i32) == 0 {
            max_sum = max_sum.max(n as i32);
        }

        current_sum = 0;
        let mut prefix = vec![-1; k];
        prefix[0] = -1;

        let mut ans = 0;
        let mut sum = 0;
        for i in 0..n {
            sum = (sum + nums[i] as i64 % (k as i64) + (k as i64)) % (k as i64);
            let rem = sum as usize;
            if prefix[rem] == -1 {
                prefix[rem] = i as i32;
            } else {
                ans = ans.max(i as i32 - prefix[rem]);
            }
        }

        ans
    }
}