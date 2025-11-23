impl Solution {
    pub fn count_symmetric_integers(low: i32, high: i32) -> i32 {
        let mut count = 0;
        for num in low..=high {
            let s = num.to_string();
            let n = s.len();
            if n % 2 != 0 {
                continue;
            }
            let half = n / 2;
            let left_sum: i32 = s[..half].chars().map(|c| c.to_digit(10).unwrap() as i32).sum();
            let right_sum: i32 = s[half..].chars().map(|c| c.to_digit(10).unwrap() as i32).sum();
            if left_sum == right_sum {
                count += 1;
            }
        }
        count
    }
}