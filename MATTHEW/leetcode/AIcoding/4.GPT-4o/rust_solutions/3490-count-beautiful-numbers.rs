impl Solution {
    pub fn count_beautiful_numbers(n: i32) -> i32 {
        let mut count = 0;
        for i in 1..=n {
            if (1..=9).any(|d| i % d == 0) && (1..=9).any(|d| i % d != 0) {
                count += 1;
            }
        }
        count
    }
}