use std::collections::HashMap;

struct Solution;

impl Solution {
    pub fn count_mentions(tweets: Vec<String>) -> HashMap<String, i32> {
        let mut mention_counts: HashMap<String, i32> = HashMap::new();

        for tweet in tweets {
            for word in tweet.split_whitespace() {
                if word.starts_with('@') {
                    let mention_candidate = &word[1..];
                    let mut cleaned_mention = String::new();

                    for c in mention_candidate.chars() {
                        if c.is_alphanumeric() || c == '_' {
                            cleaned_mention.push(c);
                        } else {
                            break;
                        }
                    }

                    if !cleaned_mention.is_empty() {
                        *mention_counts.entry(cleaned_mention).or_insert(0) += 1;
                    }
                }
            }
        }

        mention_counts
    }
}