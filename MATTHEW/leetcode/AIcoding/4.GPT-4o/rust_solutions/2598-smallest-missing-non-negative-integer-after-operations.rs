impl Solution {
    pub fn find_smallest_integer_after_operations(operations: Vec<String>) -> i32 {
        let mut count = 0;
        for op in operations {
            match op.as_str() {
                "++X" => count += 1,
                "X++" => count += 1,
                "--X" => count -= 1,
                "X--" => count -= 1,
                _ => {}
            }
        }
        if count < 0 {
            return 0;
        }
        count
    }
}