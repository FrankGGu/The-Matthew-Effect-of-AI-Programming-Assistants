impl Solution {
    pub fn array_sign(nums: Vec<i32>) -> i32 {
        let product = nums.iter().fold(1, |acc, &x| {
            if x == 0 {
                return 0;
            }
            acc * if x > 0 { 1 } else { -1 }
        });
        product.signum()
    }
}