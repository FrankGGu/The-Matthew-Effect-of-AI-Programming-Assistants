impl Solution {
    pub fn repeated_string_match(a: String, b: String) -> i32 {
        let a_len = a.len();
        let b_len = b.len();
        let mut repeated = a.clone();
        let mut count = 1;

        while repeated.len() < b_len {
            repeated.push_str(&a);
            count += 1;
        }

        if repeated.contains(&b) {
            return count;
        }

        repeated.push_str(&a);
        count += 1;

        if repeated.contains(&b) {
            return count;
        }

        -1
    }
}