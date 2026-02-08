impl Solution {
    pub fn decrypt(code: Vec<i32>, k: i32) -> Vec<i32> {
        let n = code.len();
        let mut result = vec![0; n];

        for i in 0..n {
            let mut sum = 0;
            if k > 0 {
                for j in 1..=k {
                    sum += code[(i + j as usize) % n];
                }
            } else if k < 0 {
                for j in 1..=-k {
                    sum += code[(i as i32 + (n as i32 - j) as i32) as usize % n];
                }
            }
            result[i] = sum;
        }

        result
    }
}