struct Solution;

impl Solution {
    pub fn min_operations(nums: Vec<i32>) -> i32 {
        let mut operations = 0;
        let mut flip = false;
        for num in nums {
            if flip {
                if num == 1 {
                    flip = false;
                    operations += 1;
                }
            } else {
                if num == 0 {
                    flip = true;
                    operations += 1;
                }
            }
        }
        operations
    }
}