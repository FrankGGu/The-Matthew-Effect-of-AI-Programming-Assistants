impl Solution {
    pub fn find_subsequences_with_equal_gcd(nums: Vec<i32>, k: i32) -> i64 {
        let max_possible_val = 200000;
        let mut target_nums_freq = vec![0; max_possible_val / k as usize + 1];
        let mut max_target_val = 0;

        for &num in nums.iter() {
            if num % k == 0 {
                let val = num / k;
                target_nums_freq[val as usize] += 1;
                if val > max_target_val {
                    max_target_val = val;
                }
            }
        }

        if max_target_val == 0 {
            return 0;
        }

        let mut count_multiples = vec![0; max_target_val as usize + 1];
        for i in 1..=max_target_val as usize {
            for j in (i..=max_target_val as usize).step_by(i) {
                count_multiples[i] += target_nums_freq[j];
            }
        }

        let mut ans = vec![0u64; max_target_val as usize + 1];

        for i in (1..=max_target_val as usize).rev() {
            if count_multiples[i] == 0 {
                continue;
            }

            let current_subsequences: u64 = if count_multiples[i] >= 64 {
                u64::MAX
            } else {
                (1u64 << count_multiples[i]) - 1
            };

            ans[i] = current_subsequences;

            for j in (2 * i..=max_target_val as usize).step_by(i) {
                ans[i] = ans[i].saturating_sub(ans[j]);
            }
        }

        ans[1] as i64
    }
}