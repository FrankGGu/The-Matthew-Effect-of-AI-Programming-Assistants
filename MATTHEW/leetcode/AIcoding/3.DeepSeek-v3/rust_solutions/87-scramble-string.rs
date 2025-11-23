use std::collections::HashMap;

impl Solution {
    pub fn is_scramble(s1: String, s2: String) -> bool {
        let mut memo = HashMap::new();
        Self::helper(s1.as_bytes(), s2.as_bytes(), &mut memo)
    }

    fn helper(s1: &[u8], s2: &[u8], memo: &mut HashMap<(usize, usize, usize), bool>) -> bool {
        if s1 == s2 {
            return true;
        }
        let key = (s1.as_ptr() as usize, s2.as_ptr() as usize, s1.len());
        if let Some(&res) = memo.get(&key) {
            return res;
        }
        let n = s1.len();
        let mut count = [0; 26];
        for i in 0..n {
            count[(s1[i] - b'a') as usize] += 1;
            count[(s2[i] - b'a') as usize] -= 1;
        }
        for i in 0..26 {
            if count[i] != 0 {
                memo.insert(key, false);
                return false;
            }
        }
        for i in 1..n {
            if (Self::helper(&s1[..i], &s2[..i], memo) && Self::helper(&s1[i..], &s2[i..], memo) {
                memo.insert(key, true);
                return true;
            }
            if (Self::helper(&s1[..i], &s2[n - i..], memo) && Self::helper(&s1[i..], &s2[..n - i], memo) {
                memo.insert(key, true);
                return true;
            }
        }
        memo.insert(key, false);
        false
    }
}