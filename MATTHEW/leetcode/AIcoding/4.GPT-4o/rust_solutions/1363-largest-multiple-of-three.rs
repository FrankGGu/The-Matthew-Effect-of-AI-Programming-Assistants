impl Solution {
    pub fn largest_multiple_of_three(digits: Vec<i32>) -> String {
        let mut count = vec![0; 10];
        let mut sum = 0;

        for &digit in &digits {
            count[digit as usize] += 1;
            sum += digit;
        }

        let mut remainder = sum % 3;
        if remainder != 0 {
            let found = (1..=2).find(|&r| r == remainder).and_then(|r| {
                (0..10).find(|&d| d % 3 == r && count[d as usize] > 0)
            });
            if let Some(d) = found {
                count[d as usize] -= 1;
            } else {
                let mut found_two = 0;
                for d in (0..10).rev() {
                    if count[d as usize] > 0 && d % 3 == remainder {
                        count[d as usize] -= 1;
                        found_two += 1;
                        if found_two == 2 {
                            break;
                        }
                    }
                }
            }
        }

        let mut result = String::new();
        for d in (0..10).rev() {
            for _ in 0..count[d as usize] {
                result.push_str(&d.to_string());
            }
        }

        if result.is_empty() || result == "0" {
            return "0".to_string();
        }

        result
    }
}