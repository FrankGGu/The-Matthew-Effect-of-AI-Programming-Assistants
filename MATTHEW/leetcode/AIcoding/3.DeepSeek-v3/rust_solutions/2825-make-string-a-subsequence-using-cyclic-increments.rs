impl Solution {
    pub fn can_make_subsequence(str1: String, str2: String) -> bool {
        let s1: Vec<char> = str1.chars().collect();
        let s2: Vec<char> = str2.chars().collect();
        let n = s1.len();
        let m = s2.len();
        let mut i = 0;
        let mut j = 0;

        while i < n && j < m {
            let c1 = s1[i];
            let c2 = s2[j];
            if c1 == c2 || (c1 as u8 + 1 - b'a') % 26 + b'a' == c2 as u8 {
                j += 1;
            }
            i += 1;
        }

        j == m
    }
}