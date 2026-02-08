impl Solution {
    pub fn unhappy_friends(n: i32, preferences: Vec<Vec<i32>>, pairs: Vec<Vec<i32>>) -> i32 {
        let mut adj = vec![vec![0; n as usize]; n as usize];
        for i in 0..n as usize {
            for (j, &p) in preferences[i].iter().enumerate() {
                adj[i][p as usize] = j + 1;
            }
        }

        let mut matchings = vec![0; n as usize];
        for pair in &pairs {
            matchings[pair[0] as usize] = pair[1];
            matchings[pair[1] as usize] = pair[0];
        }

        let mut unhappy = 0;
        for x in 0..n as usize {
            let y = matchings[x];
            for u in 0..n as usize {
                if x == u {
                    continue;
                }
                let v = matchings[u];
                if adj[x][u] < adj[x][y] && adj[u][x] < adj[u][v] {
                    unhappy += 1;
                    break;
                }
            }
        }

        unhappy
    }
}