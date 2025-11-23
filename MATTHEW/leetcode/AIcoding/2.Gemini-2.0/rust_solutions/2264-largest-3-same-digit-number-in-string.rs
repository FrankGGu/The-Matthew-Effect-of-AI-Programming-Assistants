impl Solution {
    pub fn largest_3_same_digit(num: String) -> String {
        let mut max_digit = None;
        for i in 0..num.len() - 2 {
            if num[i..i + 1] == num[i + 1..i + 2] && num[i..i + 1] == num[i + 2..i + 3] {
                let digit = num[i..i + 1].parse::<i32>().unwrap();
                match max_digit {
                    None => max_digit = Some(digit),
                    Some(max) => {
                        if digit > max {
                            max_digit = Some(digit);
                        }
                    }
                }
            }
        }

        match max_digit {
            None => "".to_string(),
            Some(digit) => format!("{}{}{}", digit, digit, digit),
        }
    }
}