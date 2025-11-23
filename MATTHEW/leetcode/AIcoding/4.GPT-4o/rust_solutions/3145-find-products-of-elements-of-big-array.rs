pub fn product_except_self(nums: Vec<i32>) -> Vec<i32> {
    let n = nums.len();
    let mut result = vec![1; n];
    let mut left_product = 1;

    for i in 0..n {
        result[i] = left_product;
        left_product *= nums[i];
    }

    let mut right_product = 1;
    for i in (0..n).rev() {
        result[i] *= right_product;
        right_product *= nums[i];
    }

    result
}