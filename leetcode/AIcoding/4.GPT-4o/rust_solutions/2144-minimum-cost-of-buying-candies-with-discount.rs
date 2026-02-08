impl Solution {
    pub fn minimum_cost(candy_cost: Vec<i32>) -> i32 {
        let mut candy_cost = candy_cost;
        candy_cost.sort_unstable_by(|a, b| b.cmp(a));
        candy_cost.into_iter().enumerate().map(|(i, cost)| if i % 3 == 2 { 0 } else { cost }).sum()
    }
}