impl Solution {
    pub fn min_operations(nums: Vec<i32>) -> i32 {
        let mut count = 0;
        let mut prev = -1;

        for &num in &nums {
            let target = prev + 1;
            if num <= prev {
                count += target - num;
                prev = target;
            } else {
                prev = num;
            }
        }

        count
    }
}