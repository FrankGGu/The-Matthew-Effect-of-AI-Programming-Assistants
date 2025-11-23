impl Solution {
    pub fn min_operations(num1: i32, num2: i32) -> i32 {
        let mut a = num1;
        let mut b = num2;
        let mut count = 0;

        while a != b {
            if a > b {
                a -= 1;
            } else {
                b -= 1;
            }
            count += 1;
        }

        count
    }
}