impl Solution {
    pub fn find_prefix_score(nums: Vec<i32>) -> Vec<i64> {
        let mut result = vec![0; nums.len()];
        let mut max_num = 0;
        let mut total_score = 0;

        for (i, &num) in nums.iter().enumerate() {
            max_num = max_num.max(num);
            total_score += num as i64 + max_num as i64;
            result[i] = total_score;
        }

        result
    }
}