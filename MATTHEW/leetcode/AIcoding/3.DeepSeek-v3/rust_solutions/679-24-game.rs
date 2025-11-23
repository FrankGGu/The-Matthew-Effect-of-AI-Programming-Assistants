impl Solution {
    pub fn judge_point24(nums: Vec<i32>) -> bool {
        let nums = nums.into_iter().map(|x| x as f64).collect::<Vec<_>>();
        Self::dfs(&nums)
    }

    fn dfs(nums: &[f64]) -> bool {
        if nums.len() == 1 {
            return (nums[0] - 24.0).abs() < 1e-6;
        }

        for i in 0..nums.len() {
            for j in 0..nums.len() {
                if i == j {
                    continue;
                }
                let mut next = Vec::new();
                for k in 0..nums.len() {
                    if k != i && k != j {
                        next.push(nums[k]);
                    }
                }

                for op in 0..4 {
                    let new_num = match op {
                        0 => nums[i] + nums[j],
                        1 => nums[i] - nums[j],
                        2 => nums[i] * nums[j],
                        3 => {
                            if nums[j] == 0.0 {
                                continue;
                            } else {
                                nums[i] / nums[j]
                            }
                        }
                        _ => unreachable!(),
                    };
                    next.push(new_num);
                    if Self::dfs(&next) {
                        return true;
                    }
                    next.pop();
                }
            }
        }
        false
    }
}