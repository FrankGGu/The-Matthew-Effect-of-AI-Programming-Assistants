impl Solution {
    pub fn unhappy_friends(n: i32, preferences: Vec<Vec<i32>>, pairs: Vec<Vec<i32>>) -> i32 {
        let n = n as usize;
        let mut rank = vec![vec![0; n]; n];
        for i in 0..n {
            for (r, &j) in preferences[i].iter().enumerate() {
                rank[i][j as usize] = r;
            }
        }

        let mut pair_map = vec![0; n];
        for pair in pairs {
            let x = pair[0] as usize;
            let y = pair[1] as usize;
            pair_map[x] = y;
            pair_map[y] = x;
        }

        let mut unhappy = 0;
        for x in 0..n {
            let y = pair_map[x];
            for &u in preferences[x].iter().take(rank[x][y]) {
                let v = pair_map[u as usize];
                if rank[u as usize][x] < rank[u as usize][v] {
                    unhappy += 1;
                    break;
                }
            }
        }
        unhappy
    }
}