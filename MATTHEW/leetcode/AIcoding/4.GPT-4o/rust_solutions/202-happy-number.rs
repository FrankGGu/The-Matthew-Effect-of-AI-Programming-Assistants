impl Solution {
    pub fn is_happy(n: i32) -> bool {
        let mut seen = std::collections::HashSet::new();
        let mut num = n;

        while num != 1 {
            if !seen.insert(num) {
                return false;
            }
            num = num.to_string().chars().map(|d| d.to_digit(10).unwrap() as i32).map(|d| d * d).sum();
        }
        true
    }
}