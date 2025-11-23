impl Solution {
    pub fn min_subsequence(nums: Vec<i32>) -> Vec<i32> {
        let mut nums = nums;
        nums.sort_by(|a, b| b.cmp(a));
        let total_sum: i32 = nums.iter().sum();
        let mut current_sum = 0;
        let mut result = Vec::new();

        for num in nums {
            current_sum += num;
            result.push(num);
            if current_sum > total_sum - current_sum {
                break;
            }
        }

        result
    }
}