impl Solution {
    pub fn can_eat(candies_count: Vec<i32>, queries: Vec<Vec<i32>>) -> Vec<bool> {
        let n = candies_count.len();
        let mut prefix_sum: Vec<i64> = vec![0; n + 1];
        for i in 0..n {
            prefix_sum[i + 1] = prefix_sum[i] + candies_count[i] as i64;
        }

        let mut result: Vec<bool> = Vec::new();
        for query in queries {
            let favorite_type = query[0] as usize;
            let favorite_day = query[1] as i64;
            let daily_cap = query[2] as i64;

            let min_candies_needed = favorite_day + 1;
            let max_candies_eaten = (favorite_day + 1) * daily_cap;

            let candies_before = prefix_sum[favorite_type];
            let candies_of_type = candies_count[favorite_type] as i64;

            if candies_before < max_candies_eaten && prefix_sum[favorite_type+1] > min_candies_needed -1 {
                result.push(true);
            } else {
                result.push(false);
            }
        }

        result
    }
}