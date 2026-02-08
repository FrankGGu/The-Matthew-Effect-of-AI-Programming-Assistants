impl Solution {
    pub fn count_homogenous(s: String) -> i32 {
        let mut count = 0;
        let mut current = 1;
        let bytes = s.as_bytes();

        for i in 1..bytes.len() {
            if bytes[i] == bytes[i - 1] {
                current += 1;
            } else {
                current = 1;
            }
            count = (count + current) % 1_000_000_007;
        }

        (count + current) % 1_000_000_007
    }
}