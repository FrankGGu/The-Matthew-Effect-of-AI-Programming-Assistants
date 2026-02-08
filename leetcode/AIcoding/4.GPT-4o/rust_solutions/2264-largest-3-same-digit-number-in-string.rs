impl Solution {
    pub fn largest_good_integer(num: String) -> String {
        let mut largest = String::new();
        let bytes = num.as_bytes();
        for i in 0..bytes.len() - 2 {
            if bytes[i] == bytes[i + 1] && bytes[i] == bytes[i + 2] {
                let candidate = String::from_utf8_lossy(&bytes[i..i + 3]).to_string();
                if candidate > largest {
                    largest = candidate;
                }
            }
        }
        largest
    }
}