impl Solution {
    pub fn is_circular_sentence(sentence: String) -> bool {
        let words: Vec<&str> = sentence.split_whitespace().collect();
        if words.len() == 0 {
            return true;
        }

        let n = words.len();
        if words[0].chars().next().unwrap() != words[n - 1].chars().last().unwrap() {
            return false;
        }

        for i in 0..n - 1 {
            if words[i].chars().last().unwrap() != words[i + 1].chars().next().unwrap() {
                return false;
            }
        }

        return true;
    }
}