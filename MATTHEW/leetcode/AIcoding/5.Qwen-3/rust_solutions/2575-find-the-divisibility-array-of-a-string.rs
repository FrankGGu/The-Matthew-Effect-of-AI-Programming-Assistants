struct Solution;

impl Solution {
    pub fn divisibility_array(word: String, m: i32) -> Vec<i32> {
        let mut result = Vec::new();
        let mut current = 0;
        for c in word.chars() {
            current = (current * 10 + (c as i32 - '0' as i32)) % m;
            result.push(if current == 0 { 1 } else { 0 });
        }
        result
    }
}