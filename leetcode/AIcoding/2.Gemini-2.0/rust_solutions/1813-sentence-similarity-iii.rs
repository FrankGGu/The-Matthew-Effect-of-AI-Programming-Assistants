impl Solution {
    pub fn are_sentences_similar(sentence1: String, sentence2: String) -> bool {
        let s1: Vec<&str> = sentence1.split_whitespace().collect();
        let s2: Vec<&str> = sentence2.split_whitespace().collect();

        let (mut i, mut j) = (0, 0);
        let (mut m, mut n) = (s1.len(), s2.len());

        while i < m && j < n && s1[i] == s2[j] {
            i += 1;
            j += 1;
        }

        while i < m && j < n && s1[m - 1] == s2[n - 1] {
            m -= 1;
            n -= 1;
        }

        i >= m || j >= n
    }
}