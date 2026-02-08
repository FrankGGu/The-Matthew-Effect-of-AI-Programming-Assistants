use rand::Rng;

impl Solution {
    pub fn find_secret_word(wordlist: Vec<String>, master: &Master) {
        let mut current_wordlist = wordlist.clone();
        let mut rng = rand::thread_rng();

        for _ in 0..10 {
            let guess_index = rng.gen_range(0..current_wordlist.len());
            let guess = current_wordlist[guess_index].clone();
            let matches = master.guess(&guess);

            if matches == 6 {
                return;
            }

            let mut next_wordlist = Vec::new();
            for word in &current_wordlist {
                if Solution::num_matches(&guess, word) == matches {
                    next_wordlist.push(word.clone());
                }
            }

            current_wordlist = next_wordlist;
        }
    }

    fn num_matches(word1: &str, word2: &str) -> i32 {
        let mut count = 0;
        for (c1, c2) in word1.chars().zip(word2.chars()) {
            if c1 == c2 {
                count += 1;
            }
        }
        count
    }
}