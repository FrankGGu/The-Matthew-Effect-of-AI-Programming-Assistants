impl Solution {
    pub fn find_x(arr: Vec<i32>) -> i32 {
        let mut x = 0;
        for num in arr {
            x ^= num;
        }
        x
    }
}