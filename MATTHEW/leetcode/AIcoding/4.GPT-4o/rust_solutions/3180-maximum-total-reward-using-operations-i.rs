impl Solution {
    pub fn maximum_total_reward(operations: Vec<Vec<i32>>, start: i32) -> i32 {
        let mut total_reward = start;
        let mut max_reward = 0;

        for operation in operations {
            let (reward, cost) = (operation[0], operation[1]);
            if total_reward >= cost {
                total_reward += reward - cost;
                max_reward = max_reward.max(total_reward);
            }
        }

        max_reward
    }
}