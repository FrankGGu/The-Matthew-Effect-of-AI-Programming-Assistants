impl Solution {
    pub fn decrypt(code: Vec<i32>, k: i32) -> Vec<i32> {
        let n = code.len();
        if n == 0 {
            return Vec::new();
        }

        let mut result = vec![0; n];

        if k == 0 {
            return result;
        }

        if k > 0 {
            for i in 0..n {
                let mut current_sum = 0;
                for j in 1..=k {
                    let index = (i + j as usize) % n;
                    current_sum += code[index];
                }
                result[i] = current_sum;
            }
        } else { // k < 0
            let abs_k = -k;
            for i in 0..n {
                let mut current_sum = 0;
                for j in 1..=abs_k {
                    let index = (i as i32 - j + n as i32) % n as i32;
                    current_sum += code[index as usize];
                }
                result[i] = current_sum;
            }
        }

        result
    }
}