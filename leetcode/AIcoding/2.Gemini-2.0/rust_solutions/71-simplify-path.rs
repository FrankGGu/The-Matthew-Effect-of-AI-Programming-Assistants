impl Solution {
    pub fn simplify_path(path: String) -> String {
        let mut stack: Vec<String> = Vec::new();
        for component in path.split('/') {
            match component {
                "" | "." => {},
                ".." => {
                    stack.pop();
                },
                _ => {
                    stack.push(component.to_string());
                }
            }
        }

        let mut result = String::new();
        for dir in stack {
            result.push('/');
            result.push_str(&dir);
        }

        if result.is_empty() {
            result.push('/');
        }

        result
    }
}