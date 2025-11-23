struct Solution;

impl Solution {
    const EPSILON: f64 = 1e-6;

    fn can_reach_24(&self, nums: Vec<f64>) -> bool {
        if nums.len() == 1 {
            return (nums[0] - 24.0).abs() < Self::EPSILON;
        }

        for i in 0..nums.len() {
            for j in (i + 1)..nums.len() {
                let num1 = nums[i];
                let num2 = nums[j];

                let mut remaining_nums_base = Vec::new();
                for k in 0..nums.len() {
                    if k != i && k != j {
                        remaining_nums_base.push(nums[k]);
                    }
                }

                let operations = [
                    num1 + num2,
                    num1 - num2,
                    num2 - num1,
                    num1 * num2,
                ];

                for &res in operations.iter() {
                    let mut next_nums = remaining_nums_base.clone();
                    next_nums.push(res);
                    if self.can_reach_24(next_nums) {
                        return true;
                    }
                }

                if (num2).abs() > Self::EPSILON {
                    let mut next_nums = remaining_nums_base.clone();
                    next_nums.push(num1 / num2);
                    if self.can_reach_24(next_nums) {
                        return true;
                    }
                }
                if (num1).abs() > Self::EPSILON {
                    let mut next_nums = remaining_nums_base.clone();
                    next_nums.push(num2 / num1);
                    if self.can_reach_24(next_nums) {
                        return true;
                    }
                }
            }
        }
        false
    }

    pub fn judge_point24(&self, cards: Vec<i32>) -> bool {
        let f_cards: Vec<f64> = cards.into_iter().map(|x| x as f64).collect();
        self.can_reach_24(f_cards)
    }
}