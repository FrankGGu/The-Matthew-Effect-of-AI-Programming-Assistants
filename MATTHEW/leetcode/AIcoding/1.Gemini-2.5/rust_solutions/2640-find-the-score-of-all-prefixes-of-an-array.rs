impl Solution {
    pub fn find_prefix_score(nums: Vec<i32>) -> Vec<i64> {
        let n = nums.len();
        let mut result: Vec<i64> = Vec::with_capacity(n);
        let mut current_max: i32 = 0;
        let mut total_prefix_score: i64 = 0;

        for &num in nums.iter() {
            current_max = current_max.max(num);
            let score_i = num as i64 + current_max as i64;
            total_prefix_score += score_i;
            result.push(total_prefix_score);
        }

        result
    }
}