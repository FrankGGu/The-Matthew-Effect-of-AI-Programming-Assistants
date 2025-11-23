impl Solution {
    pub fn detect_pattern(arr: Vec<i32>, m: i32, k: i32) -> bool {
        let m = m as usize;
        let k = k as usize;
        let n = arr.len();
        if n < m * k {
            return false;
        }

        for i in 0..=n - m * k {
            let mut repeated = true;
            for j in 1..k {
                for l in 0..m {
                    if arr[i + l] != arr[i + j * m + l] {
                        repeated = false;
                        break;
                    }
                }
                if !repeated {
                    break;
                }
            }
            if repeated {
                return true;
            }
        }

        false
    }
}