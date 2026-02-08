impl Solution {
    pub fn best_rotation(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let mut diff = vec![0; n + 1];
        for i in 0..n {
            let num = nums[i] as usize;
            if i >= num {
                diff[0] += 1;
                diff[i - num + 1] -= 1;
                diff[i + 1] += 1;
                diff[n] -= 1;
            } else {
                diff[i + 1] += 1;
                diff[i + n - num + 1] -= 1;
            }
        }
        let mut max_score = 0;
        let mut best_k = 0;
        let mut current_score = 0;
        for k in 0..n {
            current_score += diff[k];
            if current_score > max_score {
                max_score = current_score;
                best_k = k;
            }
        }
        best_k as i32
    }
}