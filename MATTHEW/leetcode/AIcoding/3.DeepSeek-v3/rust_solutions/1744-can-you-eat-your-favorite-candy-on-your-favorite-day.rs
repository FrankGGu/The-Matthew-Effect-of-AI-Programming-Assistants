impl Solution {
    pub fn can_eat_favorite_candy(candies_count: Vec<i32>, queries: Vec<Vec<i32>>) -> Vec<bool> {
        let n = candies_count.len();
        let mut prefix = vec![0; n + 1];
        for i in 0..n {
            prefix[i + 1] = prefix[i] + candies_count[i] as i64;
        }

        let mut res = Vec::with_capacity(queries.len());
        for q in queries {
            let favorite_type = q[0] as usize;
            let favorite_day = q[1] as i64;
            let daily_cap = q[2] as i64;

            let min_candies = favorite_day + 1;
            let max_candies = (favorite_day + 1) * daily_cap;

            let type_start = prefix[favorite_type] + 1;
            let type_end = prefix[favorite_type + 1];

            res.push(!(max_candies < type_start || min_candies > type_end));
        }
        res
    }
}