impl Solution {
    pub fn get_smallest_string(n: i32, k: i32) -> String {
        let mut k = k - n;
        let mut res = vec![b'a'; n as usize];
        for i in (0..n).rev() {
            let add = std::cmp::min(25, k);
            res[i as usize] += add as u8;
            k -= add;
            if k == 0 {
                break;
            }
        }
        String::from_utf8(res).unwrap()
    }
}