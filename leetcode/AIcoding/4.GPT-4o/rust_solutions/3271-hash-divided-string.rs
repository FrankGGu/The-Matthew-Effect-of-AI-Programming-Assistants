impl Solution {
    pub fn hash_divided_string(s: String) -> String {
        let mut hash = 0;
        for c in s.chars() {
            hash = (hash + c as u32) % 1000000007;
        }
        let mut result = String::new();
        result.push_str(&format!("{:x}", hash));
        result
    }
}