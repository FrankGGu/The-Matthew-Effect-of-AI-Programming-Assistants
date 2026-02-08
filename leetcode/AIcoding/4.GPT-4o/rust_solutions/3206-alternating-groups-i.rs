impl Solution {
    pub fn alternating_groups(nums: Vec<i32>) -> Vec<i32> {
        let mut result = Vec::new();
        let mut sum = 0;
        for (i, &num) in nums.iter().enumerate() {
            if i % 2 == 0 {
                sum += num;
            } else {
                result.push(sum);
                sum = num;
            }
        }
        result.push(sum);
        result
    }
}