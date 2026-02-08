impl Solution {
    pub fn separate_squares(nums: Vec<i32>) -> Vec<Vec<i32>> {
        let mut squares = Vec::new();
        let mut non_squares = Vec::new();

        for num in nums {
            let root = (num as f64).sqrt() as i32;
            if root * root == num {
                squares.push(num);
            } else {
                non_squares.push(num);
            }
        }

        vec![squares, non_squares]
    }
}