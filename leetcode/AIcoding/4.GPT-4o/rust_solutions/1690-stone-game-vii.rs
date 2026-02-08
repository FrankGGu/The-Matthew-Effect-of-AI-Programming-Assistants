impl Solution {
    pub fn stone_game_vii(stones: Vec<i32>) -> i32 {
        let n = stones.len();
        let mut prefix_sum = vec![0; n + 1];
        for i in 0..n {
            prefix_sum[i + 1] = prefix_sum[i] + stones[i];
        }
        let mut left = 0;
        let mut right = n - 1;
        let mut alice_score = 0;
        let mut bob_score = 0;

        while left < right {
            let left_value = stones[left];
            let right_value = stones[right];
            if prefix_sum[right + 1] - prefix_sum[left + 1] > prefix_sum[right] - prefix_sum[left] {
                alice_score += left_value;
                left += 1;
            } else {
                alice_score += right_value;
                right -= 1;
            }
        }

        alice_score
    }
}