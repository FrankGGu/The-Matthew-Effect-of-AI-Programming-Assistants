impl Solution {
    pub fn decrypt(code: Vec<i32>, k: i32) -> Vec<i32> {
        let n = code.len();
        let mut res = vec![0; n];
        if k == 0 {
            return res;
        }
        for i in 0..n {
            let mut sum = 0;
            let mut count = k.abs() as usize;
            let mut j = if k > 0 { i + 1 } else { i + n - 1 };
            while count > 0 {
                sum += code[j % n];
                count -= 1;
                j += if k > 0 { 1 } else { n - 1 };
            }
            res[i] = sum;
        }
        res
    }
}