impl Solution {
    pub fn maximum_importance(n: i32, roads: Vec<Vec<i32>>) -> i64 {
        let mut degree = vec![0; n as usize];
        for road in roads {
            degree[road[0] as usize] += 1;
            degree[road[1] as usize] += 1;
        }
        let mut importance = degree.clone();
        importance.sort_unstable();
        let total_importance: i64 = importance.iter().enumerate().map(|(i, &d)| d as i64 * (i as i64 + 1)).sum();
        total_importance
    }
}