impl Solution {
    pub fn count_complete_substrings(word: String, k: i32) -> i32 {
        let n = word.len();
        let chars: Vec<char> = word.chars().collect();
        let mut count = 0;

        for len in 1..=26 {
            if len as usize * k as usize > n {
                break;
            }

            for i in 0..=n - len as usize * k as usize {
                let mut freq = vec![0; 26];
                let mut valid = true;

                for j in i..i + len as usize * k as usize {
                    let idx = (chars[j] as u8 - 'a' as u8) as usize;
                    freq[idx] += 1;
                }

                for j in 0..26 {
                    if freq[j] > 0 && freq[j] != k {
                        valid = false;
                        break;
                    } else if freq[j] > k {
                        valid = false;
                        break;
                    }
                }

                let mut distinct_chars = 0;
                for j in 0..26 {
                    if freq[j] > 0 {
                        distinct_chars += 1;
                    }
                }

                if valid && distinct_chars == len {
                    count += 1;
                }
            }
        }

        count
    }
}