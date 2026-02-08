impl Solution {
    pub fn longest_subsequence_repeated_k(s: String, k: i32) -> String {
        let s = s.as_bytes();
        let n = s.len();
        let k = k as usize;
        let mut freq = vec![0; 26];
        for &c in s {
            freq[(c - b'a') as usize] += 1;
        }
        let mut candidates = vec![];
        for i in 0..26 {
            for _ in 0..freq[i] / k {
                candidates.push(b'a' + i as u8);
            }
        }
        candidates.sort_unstable_by(|a, b| b.cmp(a));
        let mut res = vec![];
        let mut used = vec![false; candidates.len()];
        for i in 0..candidates.len() {
            if used[i] {
                continue;
            }
            used[i] = true;
            let c = candidates[i];
            let mut new_candidates = vec![];
            let mut new_used = vec![];
            for j in 0..candidates.len() {
                if !used[j] {
                    new_candidates.push(candidates[j]);
                    new_used.push(false);
                }
            }
            let mut new_res = res.clone();
            new_res.push(c);
            if Self::is_possible(&new_res, s, k) {
                res = new_res;
                used = new_used;
            } else {
                used[i] = false;
            }
        }
        String::from_utf8(res).unwrap()
    }

    fn is_possible(sub: &[u8], s: &[u8], k: usize) -> bool {
        let mut count = 0;
        let mut i = 0;
        let n = sub.len();
        for &c in s {
            if i < n && c == sub[i] {
                i += 1;
                if i == n {
                    count += 1;
                    if count == k {
                        return true;
                    }
                    i = 0;
                }
            }
        }
        false
    }
}