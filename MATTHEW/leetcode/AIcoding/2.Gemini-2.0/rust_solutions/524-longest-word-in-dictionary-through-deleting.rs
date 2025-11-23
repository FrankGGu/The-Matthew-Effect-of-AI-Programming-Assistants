impl Solution {
    pub fn find_longest_word(s: String, dictionary: Vec<String>) -> String {
        let mut longest = String::new();
        for word in dictionary {
            if word.len() < longest.len() {
                continue;
            }
            let mut i = 0;
            let mut j = 0;
            while i < s.len() && j < word.len() {
                if s.chars().nth(i) == word.chars().nth(j) {
                    j += 1;
                }
                i += 1;
            }
            if j == word.len() {
                if word.len() > longest.len() {
                    longest = word;
                } else if word.len() == longest.len() && word < longest {
                    longest = word;
                }
            }
        }
        longest
    }
}