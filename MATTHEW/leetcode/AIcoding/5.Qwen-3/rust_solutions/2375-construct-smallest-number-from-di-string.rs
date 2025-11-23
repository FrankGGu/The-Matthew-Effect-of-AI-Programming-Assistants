impl Solution {

use std::cmp::Ordering;

struct Solution {}

impl Solution {
    pub fn find_secret_word(mut master: Vec<String>) {
        let mut possible = vec!["0".to_string(), "1".to_string(), "2".to_string(), "3".to_string(), "4".to_string(), "5".to_string(), "6".to_string(), "7".to_string(), "8".to_string(), "9".to_string()];

        for _ in 0..10 {
            let guess = possible.choose(&mut rand::thread_rng()).unwrap().clone();
            let matches = master[0].clone();
            match guess.cmp(&matches) {
                Ordering::Equal => return,
                _ => {
                    possible.retain(|x| {
                        let mut count = 0;
                        for i in 0..guess.len() {
                            if x.chars().nth(i) == guess.chars().nth(i) {
                                count += 1;
                            }
                        }
                        count == 0
                    });
                }
            }
        }
    }
}
}