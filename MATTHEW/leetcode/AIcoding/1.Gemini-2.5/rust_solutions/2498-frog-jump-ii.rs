impl Solution {
    pub fn max_jump(stones: Vec<i32>) -> i32 {
        let n = stones.len();

        if n == 2 {
            return stones[1] - stones[0];
        }

        let mut l_max = vec![0; n];
        for i in 1..n {
            l_max[i] = l_max[i - 1].max(stones[i] - stones[i - 1]);
        }

        let mut r_max = vec![0; n];
        for i in (0..n - 1).rev() {
            r_max[i] = r_max[i + 1].max(stones[i + 1] - stones[i]);
        }

        let mut min_overall_max_jump = i32::MAX;

        for k in 1..n - 1 {
            let current_max_jump = l_max[k].max(r_max[k]);
            min_overall_max_jump = min_overall_max_jump.min(current_max_jump);
        }

        min_overall_max_jump
    }
}