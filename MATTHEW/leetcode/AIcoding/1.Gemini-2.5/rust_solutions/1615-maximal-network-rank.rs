impl Solution {
    pub fn maximal_network_rank(n: i32, roads: Vec<Vec<i32>>) -> i32 {
        let n_usize = n as usize;
        let mut degrees: Vec<i32> = vec![0; n_usize];
        let mut is_connected: Vec<Vec<bool>> = vec![vec![false; n_usize]; n_usize];

        for road in roads {
            let u = road[0] as usize;
            let v = road[1] as usize;
            degrees[u] += 1;
            degrees[v] += 1;
            is_connected[u][v] = true;
            is_connected[v][u] = true;
        }

        let mut max_rank = 0;

        for i in 0..n_usize {
            for j in (i + 1)..n_usize {
                let mut current_rank = degrees[i] + degrees[j];
                if is_connected[i][j] {
                    current_rank -= 1;
                }
                if current_rank > max_rank {
                    max_rank = current_rank;
                }
            }
        }

        max_rank
    }
}