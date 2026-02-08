use std::cmp::{max, min};

impl Solution {
    pub fn strong_password_checker(s: String) -> i32 {
        let n = s.len();
        let chars: Vec<char> = s.chars().collect();

        let mut has_lower = false;
        let mut has_upper = false;
        let mut has_digit = false;

        for &c in &chars {
            if c.is_ascii_lowercase() {
                has_lower = true;
            } else if c.is_ascii_uppercase() {
                has_upper = true;
            } else if c.is_ascii_digit() {
                has_digit = true;
            }
        }

        let missing_types = (!has_lower as i32) + (!has_upper as i32) + (!has_digit as i32);

        let mut repeating_groups_k_values: Vec<usize> = Vec::new();
        let mut i = 0;
        while i < n {
            let mut j = i;
            while j < n && chars[j] == chars[i] {
                j += 1;
            }
            let k = j - i;
            if k >= 3 {
                repeating_groups_k_values.push(k);
            }
            i = j;
        }

        let mut to_replace_for_repeats = 0;
        for &k in &repeating_groups_k_values {
            to_replace_for_repeats += k / 3;
        }

        if n < 6 {
            let needed_replacements = max(missing_types, to_replace_for_repeats as i32);
            max(6 - n as i32, needed_replacements)
        } else if n <= 20 {
            max(missing_types, to_replace_for_repeats as i32)
        } else { // n > 20
            let deletions_needed = n as i32 - 20;
            let mut ans = deletions_needed;

            let mut zero_mod_groups: Vec<usize> = Vec::new(); // k for k % 3 == 0
            let mut one_mod_groups: Vec<usize> = Vec::new();  // k for k % 3 == 1
            let mut two_mod_groups: Vec<usize> = Vec::new();  // k for k % 3 == 2

            for &k in &repeating_groups_k_values {
                if k % 3 == 0 {
                    zero_mod_groups.push(k);
                } else if k % 3 == 1 {
                    one_mod_groups.push(k);
                } else { // k % 3 == 2
                    two_mod_groups.push(k);
                }
            }

            zero_mod_groups.sort_unstable();
            one_mod_groups.sort_unstable();
            two_mod_groups.sort_unstable();

            let mut deletions_left = deletions_needed;
            let mut saved_replacements = 0;

            // Priority 1: Delete 1 char from k % 3 == 0 groups (saves 1 replacement)
            for &k in &zero_mod_groups {
                if deletions_left == 0 {
                    break;
                }
                let can_save = k / 3;
                let num_to_delete = min(deletions_left, can_save as i32);
                saved_replacements += num_to_delete;
                deletions_left -= num_to_delete;
            }

            // Priority 2: Delete 2 chars from k % 3 == 1 groups (saves 1 replacement)
            for &k in &one_mod_groups {
                if deletions_left < 2 {
                    break;
                }
                let can_save = k / 3;
                let num_to_delete = min(deletions_left / 2, can_save as i32);
                saved_replacements += num_to_delete;
                deletions_left -= num_to_delete * 2;
            }

            // Priority 3: Delete 3 chars from k % 3 == 2 groups (saves 1 replacement)
            for &k in &two_mod_groups {
                if deletions_left < 3 {
                    break;
                }
                let can_save = k / 3;
                let num_to_delete = min(deletions_left / 3, can_save as i32);
                saved_replacements += num_to_delete;
                deletions_left -= num_to_delete * 3;
            }

            to_replace_for_repeats = max(0, to_replace_for_repeats as i32 - saved_replacements);

            ans += max(missing_types, to_replace_for_repeats);
            ans
        }
    }
}