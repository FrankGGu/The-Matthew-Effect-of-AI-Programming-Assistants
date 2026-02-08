impl Solution {
    pub fn count_and_say(n: i32) -> String {
        if n == 1 {
            return "1".to_string();
        }

        let mut current_seq = "1".to_string();

        for _ in 1..n {
            let mut next_seq = String::new();
            let chars: Vec<char> = current_seq.chars().collect();
            let mut i = 0;

            while i < chars.len() {
                let mut count = 1;
                let current_char = chars[i];
                let mut j = i + 1;

                while j < chars.len() && chars[j] == current_char {
                    count += 1;
                    j += 1;
                }

                next_seq.push_str(&count.to_string());
                next_seq.push(current_char);
                i = j;
            }
            current_seq = next_seq;
        }

        current_seq
    }
}