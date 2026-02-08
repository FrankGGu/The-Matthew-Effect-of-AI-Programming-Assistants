impl Solution {
    pub fn minimum_operations(n: i32) -> i32 {
        let mut operations = 0;
        let mut current = n;

        while current > 0 {
            operations += 1;
            current &= current - 1;
        }

        operations
    }
}