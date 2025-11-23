impl Solution {
    pub fn full_justify(words: Vec<String>, max_width: i32) -> Vec<String> {
        let max_width = max_width as usize;
        let mut result = Vec::new();
        let mut current_line = Vec::new();
        let mut current_len = 0;

        for word in words {
            let new_len = current_len + current_line.len() + word.len();
            if new_len > max_width {
                let spaces = max_width - current_len;
                let gaps = current_line.len() - 1;
                if gaps == 0 {
                    let mut line = current_line[0].clone();
                    line.push_str(&" ".repeat(spaces));
                    result.push(line);
                } else {
                    let base = spaces / gaps;
                    let extra = spaces % gaps;
                    let mut line = String::new();
                    for i in 0..gaps {
                        line.push_str(&current_line[i]);
                        line.push_str(&" ".repeat(base + if i < extra { 1 } else { 0 }));
                    }
                    line.push_str(&current_line[gaps]);
                    result.push(line);
                }
                current_line.clear();
                current_len = 0;
            }
            current_len += word.len();
            current_line.push(word);
        }

        if !current_line.is_empty() {
            let mut line = current_line.join(" ");
            line.push_str(&" ".repeat(max_width - line.len()));
            result.push(line);
        }

        result
    }
}