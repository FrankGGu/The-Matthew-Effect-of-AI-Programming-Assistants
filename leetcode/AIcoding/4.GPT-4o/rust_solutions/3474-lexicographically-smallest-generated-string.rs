impl Solution {
    pub fn generate_string(n: i32) -> String {
        let mut result = String::new();
        for i in 0..n {
            result.push(if i % 2 == 0 { 'a' } else { 'b' });
        }
        result
    }
}