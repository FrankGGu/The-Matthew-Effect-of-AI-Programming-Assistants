impl Solution {
    pub fn min_cost_climbing_stairs(cost: Vec<i32>) -> i32 {
        let n = cost.len();

        let mut prev2 = 0; 
        let mut prev1 = 0; 

        for i in 2..=n {
            let current = std::cmp::min(prev1 + cost[i-1], prev2 + cost[i-2]);
            prev2 = prev1;
            prev1 = current;
        }

        prev1
    }
}