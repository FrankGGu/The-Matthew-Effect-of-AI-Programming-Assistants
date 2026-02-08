impl Solution {
    pub fn best_rotation(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let mut score = vec![0; n];

        for (i, &num) in nums.iter().enumerate() {
            score[(i - num as usize + n) % n] -= 1;
            score[(i + 1) % n] += 1;
        }

        let mut max_score = 0;
        let mut best_rotation = 0;
        let mut current_score = 0;

        for i in 0..n {
            current_score += score[i];
            if current_score > max_score {
                max_score = current_score;
                best_rotation = i as i32;
            }
        }

        best_rotation
    }
}