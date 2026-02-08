impl Solution {
    pub fn contains_pattern(arr: Vec<i32>, m: i32, k: i32) -> bool {
        let m = m as usize;
        let k = k as usize;
        let n = arr.len();
        if m * k > n {
            return false;
        }
        for i in 0..=n - m * k {
            let mut valid = true;
            for j in 0..m {
                for l in 1..k {
                    if arr[i + j] != arr[i + j + l * m] {
                        valid = false;
                        break;
                    }
                }
                if !valid {
                    break;
                }
            }
            if valid {
                return true;
            }
        }
        false
    }
}