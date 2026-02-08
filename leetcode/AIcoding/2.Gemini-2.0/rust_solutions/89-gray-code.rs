impl Solution {
    pub fn gray_code(n: i32) -> Vec<i32> {
        let mut result = Vec::new();
        result.push(0);
        for i in 0..n {
            let len = result.len();
            for j in (0..len).rev() {
                result.push(result[j] | (1 << i));
            }
        }
        result
    }
}