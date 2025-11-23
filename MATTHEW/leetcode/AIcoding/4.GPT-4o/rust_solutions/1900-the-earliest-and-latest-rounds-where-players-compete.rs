pub fn earliest_and_latest(n: i32, first_player: i32, second_player: i32) -> Vec<String> {
    fn dfs(n: i32, first: i32, second: i32, round: i32) -> Vec<String> {
        if n == 2 {
            return vec![format!("{} {}", round, round)];
        }
        let mut results = Vec::new();
        let half = n / 2;
        for i in 1..=half {
            let next_first = if first == i { n - i + 1 } else { first };
            let next_second = if second == i { n - i + 1 } else { second };
            if (next_first - next_second).abs() == 1 && (next_first + next_second) == n + 1 {
                results.push(format!("{} {}", round + 1, round + 1));
            } else {
                let next_results = dfs(n - 1, next_first, next_second, round + 1);
                for result in next_results {
                    results.push(result);
                }
            }
        }
        results
    }

    let mut all_results = dfs(n, first_player, second_player, 0);
    all_results.sort();
    all_results.dedup();
    all_results
}