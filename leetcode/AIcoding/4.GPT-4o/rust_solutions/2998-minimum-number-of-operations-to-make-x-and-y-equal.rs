impl Solution {
    pub fn min_operations(x: i32, y: i32) -> i32 {
        let mut operations = 0;
        let mut a = x;
        let mut b = y;

        while a != b {
            if a > b {
                a /= 2;
            } else {
                b /= 2;
            }
            operations += 1;
        }

        operations
    }
}