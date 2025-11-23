impl Solution {
    pub fn decrypt(code: Vec<i32>, k: i32) -> Vec<i32> {
        let n = code.len();
        let mut res = vec![0; n];

        if k > 0 {
            let mut sum = code.iter().take(k as usize).sum::<i32>();
            for i in 0..n {
                res[i] = sum;
                sum -= code[i];
                sum += code[(i + k as usize) % n];
            }
        } else if k < 0 {
            let mut sum = code.iter().skip((n + k) as usize).sum::<i32>();
            for i in 0..n {
                res[i] = sum;
                sum -= code[(i + n + k) % n];
                sum += code[i];
            }
        }

        res
    }
}