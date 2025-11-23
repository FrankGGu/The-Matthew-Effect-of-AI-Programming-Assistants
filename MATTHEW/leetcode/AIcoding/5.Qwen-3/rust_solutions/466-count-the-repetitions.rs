impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn count_repetitions(s: String, m: i32, k: i32) -> i32 {
        let mut count = 0;
        let mut index = 0;
        let mut map = HashMap::new();
        let s_bytes = s.as_bytes();
        let m = m as usize;
        let k = k as usize;
        let mut total = 0;

        while count < m {
            let mut current = 0;
            let mut i = 0;
            let mut j = 0;

            while j < s_bytes.len() {
                if s_bytes[j] == b'A' {
                    i += 1;
                    if i == k {
                        current += 1;
                        i = 0;
                    }
                }
                j += 1;
            }

            if current == 0 {
                return 0;
            }

            let key = (index, current);
            if let Some(&prev_total) = map.get(&key) {
                let cycle = count - prev_total;
                let cycle_current = current - map[&key];
                let remaining = m - count;
                let cycles = remaining / cycle;
                total += cycles * cycle_current;
                count += cycles * cycle;

                if count >= m {
                    break;
                }
            } else {
                map.insert(key, count);
            }

            total += current;
            count += 1;
            index = (index + s.len()) % s.len();
        }

        total as i32
    }
}
}