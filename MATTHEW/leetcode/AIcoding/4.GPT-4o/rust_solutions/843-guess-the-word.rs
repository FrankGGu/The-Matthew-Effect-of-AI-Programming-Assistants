struct Solution;

impl Solution {
    pub fn find_secret_word(wordlist: Vec<String>, master: &mut dyn FnMut(String) -> i32) {
        let mut rng = rand::thread_rng();
        let mut wordlist = wordlist.clone();

        while !wordlist.is_empty() {
            let guess = wordlist.choose(&mut rng).unwrap().clone();
            let matches = master(guess.clone());
            if matches == 6 {
                return;
            }
            wordlist.retain(|word| Self::match_count(&guess, word) == matches);
        }
    }

    fn match_count(word1: &str, word2: &str) -> i32 {
        word1.chars().zip(word2.chars()).filter(|(a, b)| a == b).count() as i32
    }
}