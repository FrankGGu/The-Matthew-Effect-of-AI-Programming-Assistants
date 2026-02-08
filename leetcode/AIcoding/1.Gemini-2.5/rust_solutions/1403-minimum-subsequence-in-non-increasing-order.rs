impl Solution {
    pub fn min_subsequence(mut nums: Vec<i32>) -> Vec<i32> {
        nums.sort_by(|a, b| b.cmp(a));

        let total_sum: i32 = nums.iter().sum();
        let mut current_subsequence_sum: i32 = 0;
        let mut result: Vec<i32> = Vec::new();

        for &num in nums.iter() {
            current_subsequence_sum += num;
            result.push(num);
            if current_subsequence_sum > total_sum - current_subsequence_sum {
                break;
            }
        }

        result
    }
}