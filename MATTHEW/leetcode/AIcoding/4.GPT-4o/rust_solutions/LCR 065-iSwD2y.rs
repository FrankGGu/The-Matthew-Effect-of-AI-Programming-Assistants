pub fn minimum_length_encoding(words: Vec<String>) -> i32 {
    let mut words_set: std::collections::HashSet<&str> = words.iter().map(|w| w.as_str()).collect();
    let mut encoding_length = 0;

    for word in &words {
        let mut temp = String::from(word);
        temp.push('#');
        if !words_set.contains(&temp.as_str()) {
            encoding_length += word.len() + 1;
        }
    }

    encoding_length as i32
}