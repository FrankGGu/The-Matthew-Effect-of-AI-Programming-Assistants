impl Solution {
    pub fn largest_multiple_of_three(digits: Vec<i32>) -> String {
        let mut counts = [0; 10];
        let mut total_sum = 0;

        for &digit in &digits {
            counts[digit as usize] += 1;
            total_sum += digit;
        }

        let mut rem1_available_digits = Vec::new(); // Stores actual digits 1, 4, 7
        let mut rem2_available_digits = Vec::new(); // Stores actual digits 2, 5, 8

        for i in 0..10 {
            if counts[i] > 0 {
                if i % 3 == 1 {
                    rem1_available_digits.push(i as i32);
                } else if i % 3 == 2 {
                    rem2_available_digits.push(i as i32);
                }
            }
        }
        // rem1_available_digits will naturally be sorted [1, 4, 7] if present.
        // rem2_available_digits will naturally be sorted [2, 5, 8] if present.

        let remainder = total_sum % 3;

        if remainder == 1 {
            // Option 1: Remove one digit with remainder 1 (prefer this as it removes fewer digits)
            let mut removed_one_rem1 = false;
            for &d in &rem1_available_digits {
                if counts[d as usize] > 0 {
                    counts[d as usize] -= 1;
                    removed_one_rem1 = true;
                    break; // Removed the smallest available digit with remainder 1
                }
            }

            if !removed_one_rem1 {
                // Option 2: Remove two digits with remainder 2
                let mut removed_count = 0;
                for &d in &rem2_available_digits {
                    while counts[d as usize] > 0 && removed_count < 2 {
                        counts[d as usize] -= 1;
                        removed_count += 1;
                    }
                    if removed_count == 2 { break; }
                }
                // If removed_count is still < 2, it means we couldn't remove two rem2 digits.
                // In this case, no solution is possible by removing digits to satisfy remainder 1.
            }
        } else if remainder == 2 {
            // Option 1: Remove one digit with remainder 2 (prefer this as it removes fewer digits)
            let mut removed_one_rem2 = false;
            for &d in &rem2_available_digits {
                if counts[d as usize] > 0 {
                    counts[d as usize] -= 1;
                    removed_one_rem2 = true;
                    break; // Removed the smallest available digit with remainder 2
                }
            }

            if !removed_one_rem2 {
                // Option 2: Remove two digits with remainder 1
                let mut removed_count = 0;
                for &d in &rem1_available_digits {
                    while counts[d as usize] > 0 && removed_count < 2 {
                        counts[d as usize] -= 1;
                        removed_count += 1;
                    }
                    if removed_count == 2 { break; }
                }
                // If removed_count is still < 2, it means we couldn't remove two rem1 digits.
                // In this case, no solution is possible by removing digits to satisfy remainder 2.
            }
        }

        let mut result = String::new();
        for i in (0..10).rev() {
            for _ in 0..counts[i] {
                result.push_str(&i.to_string());
            }
        }

        if result.is_empty() {
            "".to_string()
        } else if result.chars().all(|c| c == '0') {
            "0".to_string()
        } else {
            result
        }
    }
}