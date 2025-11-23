pub fn full_justify(words: Vec<String>, max_width: i32) -> Vec<String> {
    let mut result = Vec::new();
    let mut current_line = Vec::new();
    let mut num_of_letters = 0;

    for word in words {
        if num_of_letters + word.len() + current_line.len() > max_width as usize {
            for i in 0..(max_width as usize - num_of_letters) {
                current_line[i % (current_line.len() - 1 + 1)] += " ";
            }
            result.push(current_line.join("").trim_end().to_string());
            current_line.clear();
            num_of_letters = 0;
        }
        current_line.push(word);
        num_of_letters += word.len();
    }

    result.push(current_line.join(" ") + &" ".repeat(max_width as usize - num_of_letters - current_line.len() + 1));
    result
}