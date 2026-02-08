impl Solution {
    pub fn minimum_operations(n: i32) -> i32 {
        let mut num = n;
        let mut operations = 0;

        while num > 0 {
            operations += num % 10;
            num /= 10;
        }

        operations
    }
}