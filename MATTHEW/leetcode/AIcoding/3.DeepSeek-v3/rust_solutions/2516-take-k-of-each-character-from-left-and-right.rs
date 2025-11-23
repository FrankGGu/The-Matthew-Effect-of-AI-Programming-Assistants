impl Solution {
    pub fn take_characters(s: String, k: i32) -> i32 {
        let s = s.chars().collect::<Vec<_>>();
        let n = s.len();
        let k = k as usize;
        let mut count = [0; 3];
        for &c in &s {
            count[(c as u8 - b'a') as usize] += 1;
        }
        if count.iter().any(|&x| x < k) {
            return -1;
        }
        let mut res = n;
        let mut left = 0;
        for right in 0..n {
            count[(s[right] as u8 - b'a') as usize] -= 1;
            while count[(s[right] as u8 - b'a') as usize] < k {
                count[(s[left] as u8 - b'a') as usize] += 1;
                left += 1;
            }
            res = res.min(n - (right - left + 1));
        }
        res as i32
    }
}