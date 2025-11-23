impl Solution {
    pub fn remove_digit(number: String, digit: char) -> String {
        let n = number.len();
        let mut max_result = String::new();

        for i in 0..n {
            if number.chars().nth(i).unwrap() == digit {
                let mut current_num = String::new();
                current_num.push_str(&number[0..i]);
                current_num.push_str(&number[i + 1..n]);

                if max_result.is_empty() || current_num > max_result {
                    max_result = current_num;
                }
            }
        }
        max_result
    }
}