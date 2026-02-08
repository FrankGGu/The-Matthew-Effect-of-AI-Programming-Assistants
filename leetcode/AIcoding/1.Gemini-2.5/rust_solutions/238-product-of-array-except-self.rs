struct Solution;

impl Solution {
    pub fn product_except_self(nums: Vec<i32>) -> Vec<i32> {
        let n = nums.len();
        let mut answer = vec![1; n];

        let mut prefix_product = 1;
        for i in 0..n {
            answer[i] = prefix_product;
            prefix_product *= nums[i];
        }

        let mut suffix_product = 1;
        for i in (0..n).rev() {
            answer[i] *= suffix_product;
            suffix_product *= nums[i];
        }

        answer
    }
}