impl Solution {
    pub fn judge_point24(cards: Vec<i32>) -> bool {
        fn solve(nums: Vec<f64>) -> bool {
            if nums.len() == 0 {
                return false;
            }
            if nums.len() == 1 {
                return (nums[0] - 24.0).abs() < 1e-6;
            }
            for i in 0..nums.len() {
                for j in 0..nums.len() {
                    if i == j {
                        continue;
                    }
                    let mut next_nums = Vec::new();
                    for k in 0..nums.len() {
                        if k != i && k != j {
                            next_nums.push(nums[k]);
                        }
                    }
                    next_nums.push(nums[i] + nums[j]);
                    if solve(next_nums.clone()) {
                        return true;
                    }
                    next_nums.pop();
                    next_nums.push(nums[i] - nums[j]);
                    if solve(next_nums.clone()) {
                        return true;
                    }
                    next_nums.pop();
                    next_nums.push(nums[i] * nums[j]);
                    if solve(next_nums.clone()) {
                        return true;
                    }
                    next_nums.pop();
                    if nums[j] != 0.0 {
                        next_nums.push(nums[i] / nums[j]);
                        if solve(next_nums.clone()) {
                            return true;
                        }
                        next_nums.pop();
                    }
                }
            }
            false
        }

        let nums: Vec<f64> = cards.iter().map(|&x| x as f64).collect();
        solve(nums)
    }
}