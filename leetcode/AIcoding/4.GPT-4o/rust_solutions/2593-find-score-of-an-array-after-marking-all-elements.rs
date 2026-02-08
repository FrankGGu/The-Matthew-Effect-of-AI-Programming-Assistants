impl Solution {
    pub fn find_score(nums: Vec<i32>) -> i64 {
        let mut nums_with_index: Vec<(i32, usize)> = nums.iter().enumerate().map(|(i, &num)| (num, i)).collect();
        nums_with_index.sort_unstable();
        let mut marked = vec![false; nums.len()];
        let mut score = 0;

        for (num, index) in nums_with_index {
            if marked[index] {
                continue;
            }
            score += num as i64;
            marked[index] = true;
            if index > 0 {
                marked[index - 1] = true;
            }
            if index < nums.len() - 1 {
                marked[index + 1] = true;
            }
        }

        score
    }
}