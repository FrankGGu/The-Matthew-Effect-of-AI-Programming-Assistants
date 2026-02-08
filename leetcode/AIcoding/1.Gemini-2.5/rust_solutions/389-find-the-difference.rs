impl Solution {
    pub fn find_the_difference(s: String, t: String) -> char {
        let mut result: u8 = 0;

        for c in s.bytes() {
            result ^= c;
        }

        for c in t.bytes() {
            result ^= c;
        }

        result as char
    }
}