impl Solution {
    pub fn sort_sentence(s: String) -> String {
        let mut words: Vec<String> = s.split_whitespace().map(|s| s.to_string()).collect();
        words.sort_by_key(|word| {
            let len = word.len();
            word[len - 1..len].parse::<i32>().unwrap()
        });

        let mut result = String::new();
        for word in words {
            let len = word.len();
            result.push_str(&word[0..len - 1]);
            result.push_str(" ");
        }

        result.trim().to_string()
    }
}