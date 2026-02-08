impl Solution {
    pub fn minimum_operations(start: i32, target: i32) -> i32 {
        let mut operations = 0;
        let mut current = start;

        while current != target {
            if current < target {
                current += 1;
            } else {
                current -= 1;
            }
            operations += 1;
        }

        operations
    }
}