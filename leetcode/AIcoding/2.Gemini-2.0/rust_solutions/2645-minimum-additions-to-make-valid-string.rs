impl Solution {
    pub fn add_minimum(word: String) -> i32 {
        let mut count = 0;
        let mut i = 0;
        let n = word.len();

        while i < n {
            if word.chars().nth(i) == Some('a') {
                i += 1;
                if i < n && word.chars().nth(i) == Some('b') {
                    i += 1;
                    if i < n && word.chars().nth(i) == Some('c') {
                        i += 1;
                    } else {
                        count += 1;
                    }
                } else {
                    count += 2;
                }
            } else if word.chars().nth(i) == Some('b') {
                count += 1;
                i += 1;
                if i < n && word.chars().nth(i) == Some('c') {
                    i += 1;
                } else {
                    count += 1;
                }
            } else {
                count += 2;
                i += 1;
            }
        }

        count
    }
}