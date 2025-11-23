impl Solution {

use std::cmp::min;

impl Solution {
    pub fn get_smallest_string(n: i32, k: i32) -> String {
        let mut res = vec!['a'; n as usize];
        let mut remaining = k - n as i32;
        let mut i = n as usize - 1;

        while remaining > 0 && i >= 0 {
            let add = min(remaining, 25);
            res[i] = (b'a' + add) as char;
            remaining -= add;
            i -= 1;
        }

        res.iter().collect()
    }
}
}