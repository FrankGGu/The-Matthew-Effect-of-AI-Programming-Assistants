impl Solution {
    pub fn at_most_n_given_digit_set(digits: Vec<String>, n: i32) -> i32 {
        let n_str = n.to_string();
        let len_n = n_str.len();
        let len_digits = digits.len();
        let mut count = 0;

        for i in 1..len_n {
            count += len_digits.pow(i as u32);
        }

        for i in 0..len_n {
            let current_digit = n_str.chars().nth(i).unwrap();
            let mut has_same_prefix = false;

            for d in &digits {
                if d.chars().next().unwrap() < current_digit {
                    count += len_digits.pow((len_n - i - 1) as u32);
                } else if d.chars().next().unwrap() == current_digit {
                    has_same_prefix = true;
                    break;
                }
            }

            if !has_same_prefix {
                break;
            }
        }

        count + 1
    }
}