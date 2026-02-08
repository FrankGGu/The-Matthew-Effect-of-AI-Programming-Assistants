impl Solution {
    pub fn largest_merge(word1: String, word2: String) -> String {
        let mut res = String::new();
        let mut word1 = word1.chars().collect::<Vec<_>>();
        let mut word2 = word2.chars().collect::<Vec<_>>();
        let mut i = 0;
        let mut j = 0;

        while i < word1.len() && j < word2.len() {
            if word1[i..] > word2[j..] {
                res.push(word1[i]);
                i += 1;
            } else {
                res.push(word2[j]);
                j += 1;
            }
        }

        res.extend(word1[i..].iter());
        res.extend(word2[j..].iter());

        res
    }
}