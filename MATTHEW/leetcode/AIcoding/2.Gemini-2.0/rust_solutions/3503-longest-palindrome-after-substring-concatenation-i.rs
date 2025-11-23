impl Solution {
    pub fn longest_palindrome(words: Vec<String>) -> i32 {
        let mut count = std::collections::HashMap::new();
        for word in &words {
            *count.entry(word.clone()).or_insert(0) += 1;
        }

        let mut ans = 0;
        let mut center = false;

        for (word, &freq) in &count {
            let reversed = word.chars().rev().collect::<String>();
            if word == &reversed {
                let pairs = freq / 2;
                ans += pairs * 4;
                if freq % 2 == 1 {
                    center = true;
                }
            } else if word < &reversed {
                if let Some(&rev_freq) = count.get(&reversed) {
                    let pairs = std::cmp::min(freq, rev_freq);
                    ans += pairs * 4;
                }
            }
        }

        if center {
            ans += 2;
        }

        ans
    }
}