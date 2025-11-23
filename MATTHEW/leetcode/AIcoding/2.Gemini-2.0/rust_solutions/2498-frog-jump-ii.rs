impl Solution {
    pub fn max_jump(stones: Vec<i32>) -> i32 {
        let n = stones.len();
        let mut ans = 0;
        for i in 0..n - 1 {
            ans = ans.max(stones[i + 1] - stones[i]);
        }
        for i in 1..n {
            ans = ans.max(stones[i] - stones[i - 1]);
        }

        let mut max_val = 0;

        for i in 0..n - 2 {
            max_val = max_val.max(stones[i+2] - stones[i]);
        }

        for i in 2..n {
            max_val = max_val.max(stones[i] - stones[i-2]);
        }

        if n > 2 {
            return max_val;
        } else {
            return ans;
        }
    }
}