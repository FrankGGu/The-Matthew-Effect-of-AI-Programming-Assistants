impl Solution {
    pub fn minimum_cost(mut cost: Vec<i32>) -> i32 {
        cost.sort_unstable_by(|a, b| b.cmp(a));

        let mut total_cost = 0;

        for i in 0..cost.len() {
            // For every three candies, the third (cheapest of the three) is free.
            // In the sorted descending list, this means we pay for the first two
            // in a group of three, and skip the third.
            // Indices for paid candies are 0, 1, 3, 4, 6, 7, ...
            // Indices for free candies are 2, 5, 8, ...
            // This can be checked by `i % 3 == 2` for the free candies.
            if i % 3 != 2 {
                total_cost += cost[i];
            }
        }

        total_cost
    }
}