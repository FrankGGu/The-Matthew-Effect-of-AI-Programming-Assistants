impl Solution {
    pub fn full_justify(words: Vec<String>, max_width: i32) -> Vec<String> {
        let mut result: Vec<String> = Vec::new();
        let mut current_line: Vec<String> = Vec::new();
        let mut current_width: i32 = 0;

        for word in words {
            let word_len = word.len() as i32;

            if current_width + current_line.len() as i32 + word_len > max_width {
                if current_line.len() == 1 {
                    let mut line = current_line.join("");
                    while line.len() < max_width as usize {
                        line.push(' ');
                    }
                    result.push(line);
                } else {
                    let spaces_needed = max_width - current_width;
                    let num_gaps = current_line.len() - 1;
                    let base_spaces = spaces_needed / num_gaps as i32;
                    let extra_spaces = spaces_needed % num_gaps as i32;

                    let mut line = String::new();
                    for i in 0..current_line.len() - 1 {
                        line.push_str(&current_line[i]);
                        for _ in 0..base_spaces {
                            line.push(' ');
                        }
                        if i < extra_spaces as usize {
                            line.push(' ');
                        }
                    }
                    line.push_str(&current_line.last().unwrap());
                    result.push(line);
                }

                current_line = Vec::new();
                current_width = 0;
            }

            current_line.push(word.clone());
            current_width += word_len;
        }

        let mut last_line = current_line.join(" ");
        while last_line.len() < max_width as usize {
            last_line.push(' ');
        }
        last_line.truncate(max_width as usize);
        result.push(last_line);

        result
    }
}