impl Solution {
    pub fn expressive_words(s: String, words: Vec<String>) -> i32 {
        fn count_characters(s: &str) -> Vec<(char, usize)> {
            let mut counts = Vec::new();
            let mut last_char = '\0';
            let mut count = 0;
            for c in s.chars() {
                if c == last_char {
                    count += 1;
                } else {
                    if count > 0 {
                        counts.push((last_char, count));
                    }
                    last_char = c;
                    count = 1;
                }
            }
            if count > 0 {
                counts.push((last_char, count));
            }
            counts
        }

        let s_count = count_characters(&s);
        let mut result = 0;

        for word in words {
            let word_count = count_characters(&word);
            if word_count.len() != s_count.len() {
                continue;
            }
            let mut matches = true;
            for ((sc, sl), (wc, wl)) in s_count.iter().zip(word_count.iter()) {
                if sc != wc || (sl != wl && (sl < 3 || sl < wl)) {
                    matches = false;
                    break;
                }
            }
            if matches {
                result += 1;
            }
        }
        result
    }
}