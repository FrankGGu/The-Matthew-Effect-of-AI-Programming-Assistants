use std::collections::HashMap;

struct Solution;

impl Solution {
    pub fn can_i_win(max_choosable_integer: i32, desired_total: i32) -> bool {
        if desired_total <= 0 {
            return true;
        }

        let sum_all_numbers = max_choosable_integer * (max_choosable_integer + 1) / 2;
        if sum_all_numbers < desired_total {
            return false;
        }

        let mut memo: HashMap<u32, bool> = HashMap::new();

        fn can_win_recursive(
            max_int: i32,
            target: i32,
            mask: u32,
            current_sum: i32,
            memo: &mut HashMap<u32, bool>,
        ) -> bool {
            if let Some(&result) = memo.get(&mask) {
                return result;
            }

            for i in 0..max_int {
                let num = i + 1;
                let bit = 1 << i;

                if (mask & bit) == 0 {
                    if current_sum + num >= target {
                        memo.insert(mask, true);
                        return true;
                    }

                    if !can_win_recursive(max_int, target, mask | bit, current_sum + num, memo) {
                        memo.insert(mask, true);
                        return true;
                    }
                }
            }

            memo.insert(mask, false);
            false
        }

        can_win_recursive(max_choosable_integer, desired_total, 0, 0, &mut memo)
    }
}