impl Solution {
    pub fn largest_even_odd(num: i32) -> i32 {
        let mut even_digits = vec![];
        let mut odd_digits = vec![];

        for ch in num.to_string().chars() {
            let digit = ch.to_digit(10).unwrap();
            if digit % 2 == 0 {
                even_digits.push(digit);
            } else {
                odd_digits.push(digit);
            }
        }

        even_digits.sort_unstable_by(|a, b| b.cmp(a));
        odd_digits.sort_unstable_by(|a, b| b.cmp(a));

        let mut result = String::new();
        let mut even_iter = even_digits.iter();
        let mut odd_iter = odd_digits.iter();

        for ch in num.to_string().chars() {
            let digit = ch.to_digit(10).unwrap();
            if digit % 2 == 0 {
                result.push_str(&even_iter.next().unwrap().to_string());
            } else {
                result.push_str(&odd_iter.next().unwrap().to_string());
            }
        }

        result.parse::<i32>().unwrap()
    }
}