impl Solution {
    pub fn verify_postorder(postorder: Vec<i32>) -> bool {
        if postorder.is_empty() {
            return true;
        }
        let mut stack = Vec::new();
        let mut root = i32::MAX;
        for &num in postorder.iter().rev() {
            if num > root {
                return false;
            }
            while !stack.is_empty() && *stack.last().unwrap() > num {
                root = stack.pop().unwrap();
            }
            stack.push(num);
        }
        true
    }
}