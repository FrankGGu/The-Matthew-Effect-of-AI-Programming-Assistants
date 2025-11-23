impl Solution {
    pub fn maximum_number(s: String, change: Vec<Vec<i32>>) -> String {
        let mut chars: Vec<char> = s.chars().collect();
        let mut mutated = false;

        for i in 0..chars.len() {
            let digit = chars[i].to_digit(10).unwrap() as i32;
            if let Some(&new_digit) = change.iter().find(|&&x| x[0] == digit) {
                if new_digit[1] > digit {
                    chars[i] = std::char::from_digit(new_digit[1] as u32, 10).unwrap();
                    mutated = true;
                } else if mutated {
                    break;
                }
            }
        }

        chars.iter().collect()
    }
}