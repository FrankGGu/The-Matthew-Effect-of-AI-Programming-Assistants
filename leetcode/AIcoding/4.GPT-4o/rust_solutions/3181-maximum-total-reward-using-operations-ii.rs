impl Solution {
    pub fn max_total_reward(n: i32, operations: Vec<Vec<i32>>) -> i32 {
        let mut rewards = vec![0; n as usize];
        for op in operations {
            let (l, r, reward) = (op[0] as usize, op[1] as usize, op[2]);
            for i in l..=r {
                rewards[i] += reward;
            }
        }
        *rewards.iter().max().unwrap()
    }
}