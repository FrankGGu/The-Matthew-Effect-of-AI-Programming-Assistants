impl Solution {
    pub fn min_operations(logs: Vec<String>) -> i32 {
        let mut depth = 0;

        for log in logs {
            if log == "../" {
                if depth > 0 {
                    depth -= 1;
                }
            } else if log == "./" {
                // Do nothing, stay in the current folder
            } else {
                // Go into a subfolder
                depth += 1;
            }
        }

        depth
    }
}