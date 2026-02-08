impl Solution {
    pub fn minimum_array_length(nums: Vec<i32>) -> i32 {
        let mut count = 0;
        let mut last = -1;

        for &num in &nums {
            if num != last {
                count += 1;
                last = num;
            }
        }

        count
    }
}