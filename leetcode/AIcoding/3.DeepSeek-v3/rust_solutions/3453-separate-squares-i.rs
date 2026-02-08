impl Solution {
    pub fn separate_squares(nums: Vec<i32>) -> Vec<i32> {
        let mut squares = Vec::new();
        let mut non_squares = Vec::new();

        for num in nums {
            if num < 0 {
                non_squares.push(num);
                continue;
            }
            let root = (num as f64).sqrt() as i32;
            if root * root == num {
                squares.push(num);
            } else {
                non_squares.push(num);
            }
        }

        squares.extend(non_squares);
        squares
    }
}