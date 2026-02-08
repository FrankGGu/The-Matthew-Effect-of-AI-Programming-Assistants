impl Solution {
    pub fn expressive_words(s: String, words: Vec<String>) -> i32 {
        let s_groups = Self::get_groups(&s);
        let mut expressive_count = 0;

        for word in words {
            let word_groups = Self::get_groups(&word);

            if s_groups.len() != word_groups.len() {
                continue;
            }

            let mut is_expressive = true;
            for i in 0..s_groups.len() {
                let (sc, sn) = s_groups[i];
                let (wc, wn) = word_groups[i];

                if sc != wc {
                    is_expressive = false;
                    break;
                }

                if sn < wn {
                    is_expressive = false;
                    break;
                }

                if sn > wn && sn < 3 {
                    is_expressive = false;
                    break;
                }
            }

            if is_expressive {
                expressive_count += 1;
            }
        }

        expressive_count
    }

    fn get_groups(s: &str) -> Vec<(char, i32)> {
        let mut groups = Vec::new();
        let mut chars = s.chars().peekable();

        while let Some(c) = chars.next() {
            let mut count = 1;
            while let Some(&next_c) = chars.peek() {
                if next_c == c {
                    count += 1;
                    chars.next();
                } else {
                    break;
                }
            }
            groups.push((c, count));
        }
        groups
    }
}