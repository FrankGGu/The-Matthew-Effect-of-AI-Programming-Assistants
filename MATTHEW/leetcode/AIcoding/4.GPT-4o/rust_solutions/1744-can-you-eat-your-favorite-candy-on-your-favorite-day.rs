impl Solution {
    pub fn can_eat(candies_count: Vec<i32>, queries: Vec<Vec<i32>>) -> Vec<bool> {
        let mut prefix_sum = vec![0; candies_count.len() + 1];
        for i in 0..candies_count.len() {
            prefix_sum[i + 1] = prefix_sum[i] + candies_count[i];
        }

        queries.into_iter().map(|q| {
            let (favorite_type, favorite_day, daily_cap) = (q[0], q[1], q[2]);
            let total_candies_before = prefix_sum[favorite_type as usize];
            let total_candies_after = prefix_sum[favorite_type as usize + 1];
            let can_eat = favorite_day + 1 <= daily_cap * (total_candies_after - total_candies_before);
            let can_finish = favorite_day < total_candies_after && (favorite_day + 1) / daily_cap < total_candies_after / daily_cap;
            can_eat && can_finish
        }).collect()
    }
}