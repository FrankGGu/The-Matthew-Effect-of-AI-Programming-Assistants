impl Solution {
    pub fn is_valid_serialization(preorder: String) -> bool {
        let mut stack = Vec::new();
        let nodes: Vec<&str> = preorder.split(',').collect();

        for node in nodes {
            stack.push(node);
            while stack.len() >= 3 && stack[stack.len() - 1] == "#" && stack[stack.len() - 2] == "#" && stack[stack.len() - 3] != "#" {
                stack.pop();
                stack.pop();
                stack.pop();
                stack.push("#");
            }
        }

        stack.len() == 1 && stack[0] == "#"
    }
}