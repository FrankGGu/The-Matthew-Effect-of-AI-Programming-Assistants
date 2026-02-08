impl Solution {
    pub fn minimal_k_sum(nums: Vec<i32>, k: i32) -> i64 {
        let mut nums = nums;
        nums.sort_unstable();

        let mut k_remaining = k as i64;
        let mut appended_sum: i64 = 0;
        let mut current_num_to_check: i64 = 1;

        for &num_i32 in nums.iter() {
            let num = num_i32 as i64;

            if k_remaining == 0 {
                break;
            }

            if num < current_num_to_check {
                continue;
            }

            if num == current_num_to_check {
                current_num_to_check = num + 1;
                continue;
            }

            let gap_size = num - current_num_to_check;
            let count_to_append = k_remaining.min(gap_size);

            if count_to_append > 0 {
                let first_val = current_num_to_check;
                let last_val = current_num_to_check + count_to_append - 1;
                appended_sum += (first_val + last_val) * count_to_append / 2;
                k_remaining -= count_to_append;
                current_num_to_check += count_to_append;
            }

            if k_remaining > 0 && current_num_to_check == num {
                current_num_to_check = num + 1;
            }
        }

        if k_remaining > 0 {
            let first_val = current_num_to_check;
            let last_val = current_num_to_check + k_remaining - 1;
            appended_sum += (first_val + last_val) * k_remaining / 2;
        }

        appended_sum
    }
}