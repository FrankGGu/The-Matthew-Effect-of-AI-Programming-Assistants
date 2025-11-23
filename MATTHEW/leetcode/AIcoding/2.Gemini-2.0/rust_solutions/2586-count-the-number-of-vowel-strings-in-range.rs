impl Solution {
    pub fn vowel_strings(words: Vec<String>, left: i32, right: i32) -> i32 {
        let mut count = 0;
        for i in left..=right {
            let word = &words[i as usize];
            if let Some(first) = word.chars().next() {
                if let Some(last) = word.chars().last() {
                    if first == 'a' || first == 'e' || first == 'i' || first == 'o' || first == 'u' {
                        if last == 'a' || last == 'e' || last == 'i' || last == 'o' || last == 'u' {
                            count += 1;
                        }
                    }
                }
            }
        }
        count
    }
}