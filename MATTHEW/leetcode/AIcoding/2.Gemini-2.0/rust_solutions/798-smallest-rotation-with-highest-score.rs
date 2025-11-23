impl Solution {
    pub fn smallest_rotation(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let mut bad = vec![0; n];
        for i in 0..n {
            let lose = (i as i32 - nums[i] + 1 + n as i32) as usize % n;
            bad[lose] -= 1;
            bad[0] += 1;
            bad[(i + 1) % n] -= 1;
            bad[lose] += 1;
        }

        let mut best_index = 0;
        let mut best_score = bad[0];
        let mut current_score = bad[0];
        for i in 1..n {
            current_score += bad[i];
            if current_score > best_score {
                best_score = current_score;
                best_index = i;
            }
        }

        best_index as i32
    }
}