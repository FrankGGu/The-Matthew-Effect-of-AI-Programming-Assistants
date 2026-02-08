impl Solution {
    pub fn largest_multiple_of_three(digits: Vec<i32>) -> String {
        let mut sum: i32 = digits.iter().sum();
        let mut count = vec![0; 10];
        for &d in &digits {
            count[d as usize] += 1;
        }

        let remove_mod = |mod_val: i32| -> bool {
            for i in mod_val..9 {
                let i = i as usize;
                if count[i] > 0 {
                    count[i] -= 1;
                    sum -= i as i32;
                    return true;
                }
            }
            false
        };

        match sum % 3 {
            1 => {
                if !remove_mod(1) {
                    remove_mod(2);
                    remove_mod(2);
                }
            },
            2 => {
                if !remove_mod(2) {
                    remove_mod(1);
                    remove_mod(1);
                }
            },
            _ => (),
        }

        let mut result = String::new();
        for d in (0..=9).rev() {
            for _ in 0..count[d] {
                result.push((d as u8 + b'0') as char);
            }
        }

        if result.is_empty() {
            String::new()
        } else if result.chars().next().unwrap() == '0' {
            "0".to_string()
        } else {
            result
        }
    }
}