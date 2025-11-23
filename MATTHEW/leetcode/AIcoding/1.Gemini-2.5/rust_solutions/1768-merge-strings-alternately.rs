impl Solution {
    pub fn merge_alternately(word1: String, word2: String) -> String {
        let mut result = String::new();
        let mut iter1 = word1.chars();
        let mut iter2 = word2.chars();

        loop {
            let char1 = iter1.next();
            let char2 = iter2.next();

            match (char1, char2) {
                (Some(c1), Some(c2)) => {
                    result.push(c1);
                    result.push(c2);
                }
                (Some(c1), None) => {
                    result.push(c1);
                    for c in iter1 {
                        result.push(c);
                    }
                    break;
                }
                (None, Some(c2)) => {
                    result.push(c2);
                    for c in iter2 {
                        result.push(c);
                    }
                    break;
                }
                (None, None) => {
                    break;
                }
            }
        }

        result
    }
}