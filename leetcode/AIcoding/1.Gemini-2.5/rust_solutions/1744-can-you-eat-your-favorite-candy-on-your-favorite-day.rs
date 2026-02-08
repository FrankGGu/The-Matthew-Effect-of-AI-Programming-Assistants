impl Solution {
    pub fn can_eat(candies_count: Vec<i32>, queries: Vec<Vec<i32>>) -> Vec<bool> {
        let n = candies_count.len();
        let mut prefix_sums: Vec<i64> = vec![0; n + 1];
        for i in 0..n {
            prefix_sums[i + 1] = prefix_sums[i] + candies_count[i] as i64;
        }

        let mut results: Vec<bool> = Vec::with_capacity(queries.len());

        for query in queries {
            let candy_type = query[0] as usize;
            let day = query[1] as i64;
            let daily_cap = query[2] as i64;

            let min_candy_idx_for_type = prefix_sums[candy_type];
            let max_candy_idx_for_type = prefix_sums[candy_type + 1] - 1;

            let earliest_possible_candy_idx_on_day = day;
            let latest_possible_candy_idx_on_day = (day + 1) * daily_cap - 1;

            let can_eat_on_day = min_candy_idx_for_type <= latest_possible_candy_idx_on_day &&
                                 max_candy_idx_for_type >= earliest_possible_candy_idx_on_day;

            results.push(can_eat_on_day);
        }

        results
    }
}