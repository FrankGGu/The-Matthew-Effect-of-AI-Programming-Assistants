impl Solution {
    pub fn maximal_network_rank(n: i32, roads: Vec<Vec<i32>>) -> i32 {
        let n = n as usize;
        let mut degrees = vec![0; n];
        let mut connected = vec![vec![false; n]; n];

        for road in roads {
            let a = road[0] as usize;
            let b = road[1] as usize;
            degrees[a] += 1;
            degrees[b] += 1;
            connected[a][b] = true;
            connected[b][a] = true;
        }

        let mut max_rank = 0;
        for i in 0..n {
            for j in i+1..n {
                let rank = degrees[i] + degrees[j] - if connected[i][j] { 1 } else { 0 };
                if rank > max_rank {
                    max_rank = rank;
                }
            }
        }

        max_rank
    }
}