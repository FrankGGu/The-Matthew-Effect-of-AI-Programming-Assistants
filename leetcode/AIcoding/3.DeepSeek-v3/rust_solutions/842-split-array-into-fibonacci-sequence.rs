impl Solution {
    pub fn split_into_fibonacci(num: String) -> Vec<i32> {
        let mut res = Vec::new();
        let bytes = num.as_bytes();
        Self::backtrack(bytes, &mut res, 0);
        res
    }

    fn backtrack(bytes: &[u8], res: &mut Vec<i32>, index: usize) -> bool {
        if index == bytes.len() && res.len() >= 3 {
            return true;
        }
        let mut num = 0i64;
        for i in index..bytes.len() {
            if i > index && bytes[index] == b'0' {
                break;
            }
            num = num * 10 + (bytes[i] - b'0') as i64;
            if num > i32::MAX as i64 {
                break;
            }
            let n = res.len();
            if n >= 2 {
                let sum = res[n - 1] as i64 + res[n - 2] as i64;
                if num < sum {
                    continue;
                } else if num > sum {
                    break;
                }
            }
            res.push(num as i32);
            if Self::backtrack(bytes, res, i + 1) {
                return true;
            }
            res.pop();
        }
        false
    }
}