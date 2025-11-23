impl Solution {
    pub fn count_unhappy_friends(n: i32, preferences: Vec<Vec<i32>>, pairs: Vec<Vec<i32>>) -> i32 {
        let n_usize = n as usize;

        let mut pref_rank: Vec<Vec<i32>> = vec![vec![0; n_usize]; n_usize];
        for i in 0..n_usize {
            for k in 0..n_usize - 1 {
                pref_rank[i][preferences[i][k] as usize] = k as i32;
            }
        }

        let mut partner: Vec<i32> = vec![0; n_usize];
        for pair in pairs {
            let x = pair[0] as usize;
            let y = pair[1] as usize;
            partner[x] = y as i32;
            partner[y] = x as i32;
        }

        let mut unhappy_friends_count = 0;

        for x_idx in 0..n_usize {
            let x = x_idx as i32;
            let y = partner[x_idx];

            for u_idx in 0..n_usize {
                let u = u_idx as i32;

                if u == x || u == y {
                    continue;
                }

                if pref_rank[x_idx][u_idx] < pref_rank[x_idx][y as usize] {
                    let v = partner[u_idx];

                    if pref_rank[u_idx][x_idx] < pref_rank[u_idx][v as usize] {
                        unhappy_friends_count += 1;
                        break;
                    }
                }
            }
        }

        unhappy_friends_count
    }
}