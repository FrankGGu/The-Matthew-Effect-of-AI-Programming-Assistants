impl Solution {
    pub fn count_binary_substrings(s: String) -> i32 {
        let bytes = s.as_bytes();
        let mut groups = vec![];
        let mut count = 1;

        for i in 1..bytes.len() {
            if bytes[i] == bytes[i - 1] {
                count += 1;
            } else {
                groups.push(count);
                count = 1;
            }
        }
        groups.push(count);

        let mut result = 0;
        for i in 1..groups.len() {
            result += groups[i].min(groups[i - 1]);
        }

        result
    }
}