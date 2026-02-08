impl Solution {
    pub fn maximum_total_importance(n: i32, roads: Vec<Vec<i32>>) -> i64 {
        let n_usize = n as usize;
        let mut degrees: Vec<i64> = vec![0; n_usize];

        for road in roads {
            let u = road[0] as usize;
            let v = road[1] as usize;
            degrees[u] += 1;
            degrees[v] += 1;
        }

        degrees.sort_unstable();

        let mut total_importance: i64 = 0;
        for i in 0..n_usize {
            total_importance += degrees[i] * (i as i64 + 1);
        }

        total_importance
    }
}