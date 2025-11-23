impl Solution {
    pub fn max_product(nums: Vec<i32>) -> i32 {
        let mut max1 = i32::MIN;
        let mut max2 = i32::MIN;
        let mut min1 = i32::MAX;
        let mut min2 = i32::MAX;

        for &num in nums.iter() {
            if num > max1 {
                max2 = max1;
                max1 = num;
            } else if num > max2 {
                max2 = num;
            }

            if num < min1 {
                min2 = min1;
                min1 = num;
            } else if num < min2 {
                min2 = num;
            }
        }

        std::cmp::max(max1 * max2, min1 * min2)
    }
}