impl Solution {
    pub fn get_smallest_string(n: i32, k: i32) -> String {
        let mut result = vec!['a'; n as usize];
        let mut remaining = k - n;
        for i in (0..n).rev() {
            let add = std::cmp::min(25, remaining);
            result[i as usize] = (b'a' + add as u8) as char;
            remaining -= add;
        }
        result.iter().collect()
    }
}