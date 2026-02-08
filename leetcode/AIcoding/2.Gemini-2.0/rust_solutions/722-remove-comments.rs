impl Solution {
    pub fn remove_comments(source: Vec<String>) -> Vec<String> {
        let mut result: Vec<String> = Vec::new();
        let mut in_block_comment = false;
        let mut current_line = String::new();

        for line in source {
            let mut i = 0;
            while i < line.len() {
                if in_block_comment {
                    if i + 1 < line.len() && line[i..i + 2] == *"*/" {
                        in_block_comment = false;
                        i += 2;
                    } else {
                        i += 1;
                    }
                } else {
                    if i + 1 < line.len() && line[i..i + 2] == *"//" {
                        break;
                    } else if i + 1 < line.len() && line[i..i + 2] == *"/*" {
                        in_block_comment = true;
                        i += 2;
                    } else {
                        current_line.push(line.chars().nth(i).unwrap());
                        i += 1;
                    }
                }
            }

            if !in_block_comment && !current_line.is_empty() {
                result.push(current_line.clone());
                current_line.clear();
            } else if in_block_comment && current_line.len() > 0{
                current_line.clear();
            }
        }

        result
    }
}