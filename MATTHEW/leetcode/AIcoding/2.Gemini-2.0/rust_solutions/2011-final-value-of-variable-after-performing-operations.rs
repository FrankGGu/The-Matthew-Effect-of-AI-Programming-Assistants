impl Solution {
    pub fn final_value_after_operations(operations: Vec<String>) -> i32 {
        let mut x = 0;
        for op in operations {
            match op.as_str() {
                "--X" | "X--" => x -= 1,
                "++X" | "X++" => x += 1,
                _ => {}
            }
        }
        x
    }
}