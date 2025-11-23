pub fn is_circular_sentence(sentence: String) -> bool {
    let words: Vec<&str> = sentence.split(' ').collect();
    let n = words.len();

    for i in 0..n {
        let current_word = words[i];
        let next_word = words[(i + 1) % n];

        if current_word.chars().last() != next_word.chars().next() {
            return false;
        }
    }
    sentence.chars().last() == sentence.chars().next()
}