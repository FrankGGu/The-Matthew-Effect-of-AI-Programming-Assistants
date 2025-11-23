impl Solution {
    pub fn monotone_increasing_digits(n: i32) -> i32 {
        let mut digits: Vec<char> = n.to_string().chars().collect();
        let len = digits.len();
        let mut marker = len;

        for i in (1..len).rev() {
            if digits[i] < digits[i - 1] {
                marker = i;
                digits[i - 1] = (digits[i - 1] as u8 - 1) as char;
            }
        }

        for i in marker..len {
            digits[i] = '9';
        }

        digits.into_iter().collect::<String>().parse().unwrap_or(0)
    }
}