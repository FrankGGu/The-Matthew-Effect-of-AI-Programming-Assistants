impl Solution {
    pub fn to_goat_latin(s: String) -> String {
        let vowels = ['a', 'e', 'i', 'o', 'u', 'A', 'E', 'I', 'O', 'U'];
        let mut result = String::new();
        let mut count = 1;

        for word in s.split_whitespace() {
            let mut temp = String::new();
            if vowels.contains(&word.chars().next().unwrap()) {
                temp.push_str(word);
            } else {
                let first = word.chars().next().unwrap();
                temp.push_str(&word[1..]);
                temp.push(first);
            }
            temp.push_str("ma");
            for _ in 0..count {
                temp.push('a');
            }
            result.push_str(&temp);
            result.push(' ');
            count += 1;
        }

        result.trim().to_string()
    }
}