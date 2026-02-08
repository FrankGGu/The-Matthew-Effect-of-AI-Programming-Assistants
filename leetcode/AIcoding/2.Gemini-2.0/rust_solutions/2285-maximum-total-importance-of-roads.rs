impl Solution {
    pub fn maximum_total_importance(n: i32, roads: Vec<Vec<i32>>) -> i64 {
        let n = n as usize;
        let mut degrees = vec![0; n];
        for road in &roads {
            degrees[road[0] as usize] += 1;
            degrees[road[1] as usize] += 1;
        }

        let mut indexed_degrees: Vec<(usize, i32)> = degrees.into_iter().enumerate().collect();
        indexed_degrees.sort_by_key(|&(_, degree)| degree);

        let mut importance = vec![0; n];
        for i in 0..n {
            importance[indexed_degrees[i].0] = (i as i64) + 1;
        }

        let mut total_importance: i64 = 0;
        for road in &roads {
            total_importance += importance[road[0] as usize] + importance[road[1] as usize];
        }

        total_importance
    }
}