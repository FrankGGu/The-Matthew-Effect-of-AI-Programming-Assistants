impl Solution {
    pub fn di_string_match(s: String) -> Vec<i32> {
        let n = s.len();
        let mut low = 0;
        let mut high = n as i32;
        let mut result = Vec::with_capacity(n + 1);

        for c in s.chars() {
            if c == 'I' {
                result.push(low);
                low += 1;
            } else {
                result.push(high);
                high -= 1;
            }
        }

        result.push(low);
        result
    }
}