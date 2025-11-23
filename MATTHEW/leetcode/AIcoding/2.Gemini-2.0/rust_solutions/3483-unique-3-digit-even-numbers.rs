impl Solution {
    pub fn find_even_numbers(digits: Vec<i32>) -> Vec<i32> {
        let mut counts = std::collections::HashMap::new();
        for &digit in &digits {
            *counts.entry(digit).or_insert(0) += 1;
        }

        let mut result = vec![];

        for i in 100..=998 {
            if i % 2 != 0 {
                continue;
            }

            let mut temp_counts = counts.clone();
            let mut valid = true;

            let digit1 = i / 100;
            let digit2 = (i % 100) / 10;
            let digit3 = i % 10;

            if let Some(count) = temp_counts.get_mut(&digit1) {
                if *count > 0 {
                    *count -= 1;
                } else {
                    valid = false;
                }
            } else {
                valid = false;
            }

            if valid {
                if let Some(count) = temp_counts.get_mut(&digit2) {
                    if *count > 0 {
                        *count -= 1;
                    } else {
                        valid = false;
                    }
                } else {
                    valid = false;
                }
            }

            if valid {
                if let Some(count) = temp_counts.get_mut(&digit3) {
                    if *count > 0 {
                        *count -= 1;
                    } else {
                        valid = false;
                    }
                } else {
                    valid = false;
                }
            }

            if valid {
                result.push(i);
            }
        }

        result.sort();
        result.dedup();
        result
    }
}