struct Solution;

impl Solution {
    pub fn largest_merge(word1: String, word2: String) -> String {
        let mut merge = String::new();
        let mut i = 0;
        let mut j = 0;
        let s1 = word1.as_bytes();
        let s2 = word2.as_bytes();

        while i < s1.len() && j < s2.len() {
            if &s1[i..] >= &s2[j..] {
                merge.push(s1[i] as char);
                i += 1;
            } else {
                merge.push(s2[j] as char);
                j += 1;
            }
        }

        while i < s1.len() {
            merge.push(s1[i] as char);
            i += 1;
        }

        while j < s2.len() {
            merge.push(s2[j] as char);
            j += 1;
        }

        merge
    }
}