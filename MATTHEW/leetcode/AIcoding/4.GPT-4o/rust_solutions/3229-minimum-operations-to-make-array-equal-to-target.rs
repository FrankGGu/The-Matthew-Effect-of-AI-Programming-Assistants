impl Solution {
    pub fn min_operations(n: i32, target: i32) -> i32 {
        let mut operations = 0;
        let mut diff = target - n;
        if diff < 0 {
            diff = -diff;
        }
        operations += diff / 2;
        operations += diff % 2;
        operations
    }
}