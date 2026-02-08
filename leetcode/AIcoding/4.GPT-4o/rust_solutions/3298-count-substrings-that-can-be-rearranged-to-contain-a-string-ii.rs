impl Solution {
    pub fn count_substrings(s: String, t: String) -> i32 {
        let s = s.as_bytes();
        let t = t.as_bytes();
        let n = s.len();
        let m = t.len();

        let mut result = 0;

        for k in 1..=n {
            let mut count = vec![0; 26];
            for i in 0..k {
                count[(s[i] - b'a') as usize] += 1;
            }
            for j in 0..m {
                if j + k <= m {
                    let mut curr_count = count.clone();
                    for i in 0..k {
                        curr_count[(t[j + i] - b'a') as usize] -= 1;
                    }
                    if curr_count.iter().all(|&x| x >= 0) {
                        result += 1;
                    }
                }
            }
            for i in 1..=(n - k) {
                count[(s[i - 1] - b'a') as usize] -= 1;
                count[(s[i + k - 1] - b'a') as usize] += 1;
                for j in 0..m {
                    if j + k <= m {
                        let mut curr_count = count.clone();
                        for l in 0..k {
                            curr_count[(t[j + l] - b'a') as usize] -= 1;
                        }
                        if curr_count.iter().all(|&x| x >= 0) {
                            result += 1;
                        }
                    }
                }
            }
        }
        result
    }
}