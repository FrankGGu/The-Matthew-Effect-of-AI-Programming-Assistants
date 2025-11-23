impl Solution {
    pub fn count_complete_substrings(word: String, k: i32) -> i32 {
        let word = word.as_bytes();
        let n = word.len();
        let mut res = 0;

        for len in 1..=26 {
            let m = len * k as usize;
            if m > n {
                continue;
            }

            let mut freq = vec![0; 26];
            let mut unique = 0;
            let mut valid = 0;

            for i in 0..n {
                let c = (word[i] - b'a') as usize;

                if i >= m {
                    let old_c = (word[i - m] - b'a') as usize;
                    freq[old_c] -= 1;
                    if freq[old_c] == 0 {
                        unique -= 1;
                    }
                    if freq[old_c] == k - 1 {
                        valid -= 1;
                    }
                }

                freq[c] += 1;
                if freq[c] == 1 {
                    unique += 1;
                }
                if freq[c] == k {
                    valid += 1;
                }

                if i >= m - 1 && unique == len && valid == len {
                    let mut is_valid = true;
                    for j in i - m + 1..i {
                        if (word[j] as i32 - word[j + 1] as i32).abs() > 2 {
                            is_valid = false;
                            break;
                        }
                    }
                    if is_valid {
                        res += 1;
                    }
                }
            }
        }

        res
    }
}