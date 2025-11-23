impl Solution {
    pub fn decrypt(code: Vec<i32>, k: i32) -> Vec<i32> {
        let n = code.len();
        let mut result = vec![0; n];

        if k > 0 {
            for i in 0..n {
                for j in 1..=k {
                    result[i] += code[(i + j) % n];
                }
            }
        } else if k < 0 {
            for i in 0..n {
                for j in 1..=(-k) {
                    result[i] += code[(i + n - j) % n];
                }
            }
        }

        result
    }
}