impl Solution {
    pub fn build_array(target: Vec<i32>, n: i32) -> Vec<String> {
        let mut operations: Vec<String> = Vec::new();
        let mut target_idx = 0;

        for i in 1..=n {
            if target_idx == target.len() {
                break;
            }

            if target[target_idx] == i {
                operations.push("Push".to_string());
                target_idx += 1;
            } else {
                operations.push("Push".to_string());
                operations.push("Pop".to_string());
            }
        }

        operations
    }
}