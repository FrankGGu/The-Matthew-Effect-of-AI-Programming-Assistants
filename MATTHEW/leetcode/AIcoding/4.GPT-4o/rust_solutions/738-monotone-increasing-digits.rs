impl Solution {
    pub fn monotone_increasing_digits(n: i32) -> i32 {
        let mut digits = n.to_string().chars().collect::<Vec<_>>();
        let len = digits.len();
        let mut mark = len;

        for i in (1..len).rev() {
            if digits[i] < digits[i - 1] {
                mark = i;
                digits[i - 1] = (digits[i - 1] as u8 - 1) as char;
            }
        }

        for i in mark..len {
            digits[i] = '9';
        }

        digits.iter().collect::<String>().parse::<i32>().unwrap()
    }
}