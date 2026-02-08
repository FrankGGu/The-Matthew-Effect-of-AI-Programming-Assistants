use std::collections::HashMap;

impl Solution {
    pub fn longest_palindrome(words: Vec<String>) -> i32 {
        let mut count: HashMap<String, i32> = HashMap::new();
        for word in &words {
            *count.entry(word.clone()).or_insert(0) += 1;
        }

        let mut ans = 0;
        let mut central = false;

        for (word, cnt) in count.clone().iter() {
            let reversed = word.chars().rev().collect::<String>();

            if word == &reversed {
                let even = cnt / 2;
                ans += even * 4;
                if cnt % 2 == 1 {
                    central = true;
                }
            } else if word < &reversed {
                if let Some(rev_cnt) = count.get(&reversed) {
                    let pair = std::cmp::min(*cnt, *rev_cnt);
                    ans += pair * 4;
                }
            }
        }

        if central {
            ans += 2;
        }

        ans
    }
}