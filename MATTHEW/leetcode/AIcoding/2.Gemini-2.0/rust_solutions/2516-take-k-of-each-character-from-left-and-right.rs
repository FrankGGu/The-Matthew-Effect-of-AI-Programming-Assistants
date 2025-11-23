impl Solution {
    pub fn take_characters(s: String, k: i32) -> i32 {
        let n = s.len();
        let k = k as usize;
        let s: Vec<char> = s.chars().collect();
        let mut count = vec![0; 3];
        for &c in &s {
            count[(c as u8 - b'a') as usize] += 1;
        }
        if count[0] < k || count[1] < k || count[2] < k {
            return -1;
        }

        let mut l = 0;
        let mut res = 0;
        let mut curr = vec![0; 3];

        for r in 0..n {
            curr[(s[r] as u8 - b'a') as usize] += 1;
            while curr[0] >= count[0] - k && curr[1] >= count[1] - k && curr[2] >= count[2] - k {
                curr[(s[l] as u8 - b'a') as usize] -= 1;
                l += 1;
            }
            res = res.max(r - l + 1);
        }

        n as i32 - res as i32
    }
}