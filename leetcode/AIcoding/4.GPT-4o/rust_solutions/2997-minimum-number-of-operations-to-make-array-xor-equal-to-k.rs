impl Solution {
    pub fn min_operations(n: i32, start: i32, goal: i32) -> i32 {
        let target = start ^ goal;
        let mut operations = 0;
        let mut current = 0;

        while current < target {
            operations += 1;
            current += 2 * operations;
        }

        operations
    }
}