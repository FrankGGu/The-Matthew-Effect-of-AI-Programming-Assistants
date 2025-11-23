pub fn remove_comments(source: Vec<String>) -> Vec<String> {
    let mut result = Vec::new();
    let mut in_block = false;
    let mut current_line = String::new();

    for line in source {
        let mut i = 0;
        while i < line.len() {
            if in_block {
                if i + 1 < line.len() && &line[i..i + 2] == "*/" {
                    in_block = false;
                    i += 1;
                }
            } else {
                if i + 1 < line.len() && &line[i..i + 2] == "//" {
                    break;
                } else if i + 1 < line.len() && &line[i..i + 2] == "/*" {
                    in_block = true;
                    i += 1;
                } else {
                    current_line.push(line.chars().nth(i).unwrap());
                }
            }
            i += 1;
        }

        if !in_block && !current_line.is_empty() {
            result.push(current_line.clone());
            current_line.clear();
        }
    }

    if !current_line.is_empty() && !in_block {
        result.push(current_line);
    }

    result
}