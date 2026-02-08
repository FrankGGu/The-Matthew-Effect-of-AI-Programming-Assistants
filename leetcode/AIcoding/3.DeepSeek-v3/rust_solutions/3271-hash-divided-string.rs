impl Solution {
    pub fn divide_string(s: String, k: i32, fill: char) -> Vec<String> {
        let k = k as usize;
        let mut result = Vec::new();
        let chars: Vec<char> = s.chars().collect();
        let mut i = 0;
        while i < chars.len() {
            let mut part = String::new();
            for j in 0..k {
                if i + j < chars.len() {
                    part.push(chars[i + j]);
                } else {
                    part.push(fill);
                }
            }
            result.push(part);
            i += k;
        }
        result
    }
}