impl Solution {
    pub fn vowel_strings(words: Vec<String>, left: i32, right: i32) -> i32 {
        let vowels = |c: char| "aeiou".contains(c);
        (left..=right)
            .filter(|&i| {
                let word = &words[i as usize];
                vowels(word.chars().next().unwrap()) && vowels(word.chars().last().unwrap())
            })
            .count() as i32
    }
}