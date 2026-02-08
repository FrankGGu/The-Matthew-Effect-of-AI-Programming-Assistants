impl Solution {
    pub fn smallest_number(num: i64) -> i64 {
        if num == 0 {
            return 0;
        }

        let mut digits: Vec<char> = num.to_string().chars().collect();
        digits.sort_unstable();

        if digits[0] != '0' {
            return digits.iter().collect::<String>().parse::<i64>().unwrap();
        }

        let mut first_non_zero_idx = 0;
        for i in 0..digits.len() {
            if digits[i] != '0' {
                first_non_zero_idx = i;
                break;
            }
        }

        digits.swap(0, first_non_zero_idx);

        digits.iter().collect::<String>().parse::<i64>().unwrap()
    }
}