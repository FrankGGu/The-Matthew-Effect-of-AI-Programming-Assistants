impl Solution {
    pub fn maximum_length(good: Vec<String>) -> i32 {
        let mut max_len = 0;
        let n = good.len();

        for mask in 1..(1 << n) {
            let mut seen = vec![false; 26];
            let mut length = 0;
            let mut valid = true;

            for i in 0..n {
                if mask & (1 << i) != 0 {
                    for ch in good[i].chars() {
                        let idx = (ch as usize - 'a' as usize);
                        if seen[idx] {
                            valid = false;
                            break;
                        }
                        seen[idx] = true;
                    }
                    if valid {
                        length += good[i].len();
                    } else {
                        break;
                    }
                }
            }
            if valid {
                max_len = max_len.max(length);
            }
        }
        max_len as i32
    }
}