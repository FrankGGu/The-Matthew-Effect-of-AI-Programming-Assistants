struct KMP {
    pattern: Vec<i32>,
    lps: Vec<usize>,
}

impl KMP {
    fn new(pattern: Vec<i32>) -> Self {
        let m = pattern.len();
        let mut lps = vec![0; m];
        if m == 0 {
            return KMP { pattern, lps };
        }

        let mut length = 0; // length of the previous longest prefix suffix
        let mut i = 1;

        while i < m {
            if pattern[i] == pattern[length] {
                length += 1;
                lps[i] = length;
                i += 1;
            } else {
                if length != 0 {
                    length = lps[length - 1];
                } else {
                    lps[i] = 0;
                    i += 1;
                }
            }
        }
        KMP { pattern, lps }
    }

    // Searches for the pattern in `text` starting from `start_idx`.
    // Returns the absolute starting index in `text` if found, otherwise `None`.
    fn search(&self, text: &[i32], start_idx: usize) -> Option<usize> {
        let n = text.len();
        let m = self.pattern.len();

        if m == 0 {
            return Some(start_idx); // Empty pattern matches at start_idx
        }
        if m > n - start_idx {
            return None; // Pattern longer than remaining text
        }

        let mut i = start_idx; // index for text
        let mut j = 0;          // index for pattern

        while i < n {
            if self.pattern[j] == text[i] {
                i += 1;
                j += 1;
            }

            if j == m {
                return Some(i - j); // Pattern found, return its starting index
            } else if i < n && self.pattern[j] != text[i] {
                if j != 0 {
                    j = self.lps[j - 1];
                } else {
                    i += 1;
                }
            }
        }
        None
    }
}

impl Solution {
    pub fn can_choose(groups: Vec<Vec<i32>>, nums: Vec<i32>) -> bool {
        let mut nums_ptr = 0; // Current starting index in `nums` for the search

        for group in groups {
            if group.is_empty() {
                continue; 
            }

            let kmp_matcher = KMP::new(group.clone());

            match kmp_matcher.search(&nums, nums_ptr) {
                Some(match_start_idx) => {
                    // Group found, update nums_ptr to start search for next group *after* this one
                    nums_ptr = match_start_idx + group.len();
                },
                None => {
                    // Current group not found, so we cannot form the array
                    return false;
                }
            }
        }

        true // All groups found
    }
}