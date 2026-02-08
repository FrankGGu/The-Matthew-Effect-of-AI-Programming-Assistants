impl Solution {
    pub fn find_substring_in_wrapround_string(p: String) -> i32 {
        let p = p.as_bytes();
        let mut count = [0; 26];
        let mut max_len = 0;

        for i in 0..p.len() {
            if i > 0 && (p[i] as i32 - p[i - 1] as i32 == 1 || p[i - 1] - p[i] == 25) {
                max_len += 1;
            } else {
                max_len = 1;
            }
            let idx = (p[i] - b'a') as usize;
            count[idx] = count[idx].max(max_len);
        }

        count.iter().sum()
    }
}