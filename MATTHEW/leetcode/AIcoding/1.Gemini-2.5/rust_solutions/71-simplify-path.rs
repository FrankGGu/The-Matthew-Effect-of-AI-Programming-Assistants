impl Solution {
    pub fn simplify_path(path: String) -> String {
        let mut stack: Vec<String> = Vec::new();

        for component in path.split('/') {
            match component {
                "." | "" => {
                    // Ignore current directory or empty strings
                }
                ".." => {
                    // Go up one level
                    stack.pop();
                }
                _ => {
                    // Push directory name onto the stack
                    stack.push(component.to_string());
                }
            }
        }

        if stack.is_empty() {
            "/".to_string()
        } else {
            format!("/{}", stack.join("/"))
        }
    }
}