impl Solution {
    pub fn longest_awesome(s: String) -> i32 {
        let s = s.as_bytes();
        let n = s.len();
        let mut mask = 0;
        let mut first = vec![n; 1024];
        first[0] = 0;
        let mut ans = 0;
        for i in 0..n {
            let digit = (s[i] - b'0') as usize;
            mask ^= 1 << digit;
            if first[mask] == n {
                first[mask] = i + 1;
            }
            ans = ans.max(i as i32 + 1 - first[mask] as i32);
            for j in 0..10 {
                let temp_mask = mask ^ (1 << j);
                if first[temp_mask] != n {
                    ans = ans.max(i as i32 + 1 - first[temp_mask] as i32);
                }
            }
        }
        ans
    }
}