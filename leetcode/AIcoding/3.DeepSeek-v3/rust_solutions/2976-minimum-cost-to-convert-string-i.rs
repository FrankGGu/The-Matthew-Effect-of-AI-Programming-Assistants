impl Solution {
    pub fn minimum_cost(source: String, target: String, original: Vec<char>, changed: Vec<char>, cost: Vec<i32>) -> i64 {
        let mut dist = vec![vec![i64::MAX / 2; 26]; 26];
        for i in 0..26 {
            dist[i][i] = 0;
        }
        for i in 0..original.len() {
            let u = original[i] as usize - 'a' as usize;
            let v = changed[i] as usize - 'a' as usize;
            dist[u][v] = dist[u][v].min(cost[i] as i64);
        }
        for k in 0..26 {
            for i in 0..26 {
                for j in 0..26 {
                    dist[i][j] = dist[i][j].min(dist[i][k] + dist[k][j]);
                }
            }
        }
        let mut res = 0;
        for (s, t) in source.chars().zip(target.chars()) {
            let u = s as usize - 'a' as usize;
            let v = t as usize - 'a' as usize;
            if dist[u][v] == i64::MAX / 2 {
                return -1;
            }
            res += dist[u][v];
        }
        res
    }
}