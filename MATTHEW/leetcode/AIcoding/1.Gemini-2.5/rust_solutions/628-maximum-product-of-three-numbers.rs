impl Solution {
    pub fn maximum_product(mut nums: Vec<i32>) -> i32 {
        nums.sort_unstable();
        let n = nums.len();

        // Case 1: Product of the three largest numbers
        // This covers cases where all numbers are positive, or a mix where the largest three are positive.
        let product_three_largest = nums[n - 1] * nums[n - 2] * nums[n - 3];

        // Case 2: Product of the two smallest (most negative) numbers and the largest positive number
        // This covers cases where there are two very negative numbers that, when multiplied, become large positive,
        // and then multiplied by the largest positive number.
        let product_two_smallest_one_largest = nums[0] * nums[1] * nums[n - 1];

        product_three_largest.max(product_two_smallest_one_largest)
    }
}