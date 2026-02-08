use std::collections::HashMap;

impl Solution {
    pub fn min_anagram_length(s: String) -> i32 {
        let n = s.len();
        let s_bytes = s.as_bytes();
        let mut freq = HashMap::new();

        for &c in s_bytes {
            *freq.entry(c).or_insert(0) += 1;
        }

        let k = freq.values().fold(0, |acc, &v| gcd(acc, v)) as usize;

        for len in 1..=n {
            if n % len != 0 {
                continue;
            }
            let m = n / len;
            if m % k != 0 {
                continue;
            }
            let t = m / k;
            let mut valid = true;
            for i in 0..t {
                let start = i * len * k;
                let end = start + len * k;
                if !Self::is_valid(&s_bytes[start..end], len, k) {
                    valid = false;
                    break;
                }
            }
            if valid {
                return len as i32;
            }
        }

        n as i32
    }

    fn is_valid(s: &[u8], len: usize, k: usize) -> bool {
        let mut freq = HashMap::new();
        for &c in s {
            *freq.entry(c).or_insert(0) += 1;
        }
        for &count in freq.values() {
            if count % k != 0 {
                return false;
            }
        }
        true
    }
}

fn gcd(a: usize, b: usize) -> usize {
    if b == 0 {
        a
    } else {
        gcd(b, a % b)
    }
}