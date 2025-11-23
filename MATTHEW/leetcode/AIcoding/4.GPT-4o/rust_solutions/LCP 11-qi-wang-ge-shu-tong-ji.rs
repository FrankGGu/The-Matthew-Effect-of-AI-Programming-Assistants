pub fn get_expectation_count(queries: Vec<i32>) -> f64 {
    let max_query = *queries.iter().max().unwrap();
    let mut dp = vec![0.0; (max_query + 1) as usize];

    for i in 1..=max_query {
        let mut total = 0.0;
        for j in 1..=i {
            total += dp[j as usize];
        }
        dp[i as usize] = (total + 1.0) / i as f64;
    }

    let mut result = 0.0;
    for query in queries {
        result += dp[query as usize];
    }

    result
}