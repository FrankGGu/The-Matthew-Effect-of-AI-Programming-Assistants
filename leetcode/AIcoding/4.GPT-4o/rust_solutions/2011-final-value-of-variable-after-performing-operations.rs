impl Solution {
    pub fn final_value_after_operations(operations: Vec<String>) -> i32 {
        operations.iter().fold(0, |acc, op| {
            match op.as_str() {
                "++X" | "X++" => acc + 1,
                "--X" | "X--" => acc - 1,
                _ => acc,
            }
        })
    }
}