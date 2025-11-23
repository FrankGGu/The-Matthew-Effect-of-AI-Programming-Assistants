impl Solution {
    pub fn vowel_strings(words: Vec<String>, left: i32, right: i32) -> i32 {
        let vowels: [char; 5] = ['a', 'e', 'i', 'o', 'u'];
        let mut count = 0;
        for i in left..=right {
            let word = &words[i as usize];
            let first_char = word.chars().next().unwrap();
            let last_char = word.chars().last().unwrap();
            if vowels.contains(&first_char) && vowels.contains(&last_char) {
                count += 1;
            }
        }
        count
    }
}