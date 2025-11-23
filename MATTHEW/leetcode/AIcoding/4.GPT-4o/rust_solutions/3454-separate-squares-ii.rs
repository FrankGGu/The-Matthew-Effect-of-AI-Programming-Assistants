impl Solution {
    pub fn separate_squares(nums: Vec<i32>) -> Vec<i32> {
        let mut squares = Vec::new();
        let mut non_squares = Vec::new();

        for &num in &nums {
            let sqrt = (num as f64).sqrt();
            if sqrt == sqrt.round() {
                squares.push(num);
            } else {
                non_squares.push(num);
            }
        }

        squares.append(&mut non_squares);
        squares
    }
}