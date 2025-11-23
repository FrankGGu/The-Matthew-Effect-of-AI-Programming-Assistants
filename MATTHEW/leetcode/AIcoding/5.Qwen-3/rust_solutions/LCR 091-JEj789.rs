impl Solution {
    pub fn min_cost(costs: Vec<Vec<i32>>) -> i32 {
        if costs.is_empty() {
            return 0;
        }

        let n = costs.len();
        let mut prev = costs[0].clone();

        for i in 1..n {
            let curr = vec![
                costs[i][0] + prev[1].min(prev[2]),
                costs[i][1] + prev[0].min(prev[2]),
                costs[i][2] + prev[0].min(prev[1]),
            ];
            prev = curr;
        }

        prev.iter().min().copied().unwrap()
    }
}