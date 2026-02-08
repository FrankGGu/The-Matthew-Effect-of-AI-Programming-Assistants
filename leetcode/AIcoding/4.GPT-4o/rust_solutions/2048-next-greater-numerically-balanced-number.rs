impl Solution {
    pub fn next_greater_numerically_balanced_number(n: i32) -> i32 {
        let mut digits: Vec<i32> = n.to_string().chars().map(|d| d.to_digit(10).unwrap() as i32).collect();
        let len = digits.len();

        for i in (0..len - 1).rev() {
            if digits[i] < digits[i + 1] {
                let mut j = len - 1;
                while digits[j] <= digits[i] {
                    j -= 1;
                }
                digits.swap(i, j);
                digits[i + 1..].sort();
                let result: i32 = digits.iter().fold(0, |acc, &d| acc * 10 + d);
                return if result > n { result } else { -1 };
            }
        }
        -1
    }
}