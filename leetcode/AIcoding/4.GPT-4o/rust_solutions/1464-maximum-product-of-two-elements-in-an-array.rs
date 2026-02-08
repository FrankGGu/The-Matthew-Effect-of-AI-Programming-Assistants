impl Solution {
    pub fn max_product(nums: Vec<i32>) -> i32 {
        let (mut first, mut second) = (0, 0);
        for &num in &nums {
            if num > first {
                second = first;
                first = num;
            } else if num > second {
                second = num;
            }
        }
        (first - 1) * (second - 1)
    }
}