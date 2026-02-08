impl Solution {
    pub fn next_greater_element(n: i32) -> i32 {
        let mut digits: Vec<i32> = n.to_string().chars().map(|d| d.to_digit(10).unwrap() as i32).collect();
        let len = digits.len();
        let mut i = len - 2;

        while i >= 0 && digits[i] >= digits[i + 1] {
            i -= 1;
        }

        if i < 0 {
            return -1;
        }

        let mut j = len - 1;
        while digits[j] <= digits[i] {
            j -= 1;
        }

        digits.swap(i, j);
        digits[i + 1..].reverse();

        let result: i64 = digits.iter().fold(0, |acc, &x| acc * 10 + x as i64);
        if result > i32::MAX as i64 {
            return -1;
        }

        result as i32
    }
}