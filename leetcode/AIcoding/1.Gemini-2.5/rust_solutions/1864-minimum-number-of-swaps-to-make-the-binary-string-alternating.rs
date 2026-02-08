impl Solution {
    pub fn min_swaps(s: String) -> i32 {
        let n = s.len();
        let mut count0 = 0;
        let mut count1 = 0;

        for c in s.chars() {
            if c == '0' {
                count0 += 1;
            } else {
                count1 += 1;
            }
        }

        if (count0 as i32 - count1 as i32).abs() > 1 {
            return -1;
        }

        let mut ans = i32::MAX;

        let calculate_mismatches = |s_ref: &str, start_char: char| -> i32 {
            let mut mismatches = 0;
            let mut current_expected_char = start_char;
            for c in s_ref.chars() {
                if c != current_expected_char {
                    mismatches += 1;
                }
                current_expected_char = if current_expected_char == '0' { '1' } else { '0' };
            }
            mismatches
        };

        if count0 >= count1 {
            let mismatches_for_0_start = calculate_mismatches(&s, '0');
            ans = ans.min(mismatches_for_0_start / 2);
        }

        if count1 >= count0 {
            let mismatches_for_1_start = calculate_mismatches(&s, '1');
            ans = ans.min(mismatches_for_1_start / 2);
        }

        ans
    }
}