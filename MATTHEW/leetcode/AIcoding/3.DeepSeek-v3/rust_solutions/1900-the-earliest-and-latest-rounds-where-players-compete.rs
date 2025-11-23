impl Solution {
    pub fn earliest_and_latest(n: i32, first_player: i32, second_player: i32) -> Vec<i32> {
        let n = n as usize;
        let first = first_player as usize - 1;
        let second = second_player as usize - 1;
        let mut earliest = n;
        let mut latest = 0;

        fn dfs(mask: usize, round: i32, n: usize, first: usize, second: usize, earliest: &mut i32, latest: &mut i32) {
            let players: Vec<usize> = (0..n).filter(|&i| (mask & (1 << i)) != 0).collect();
            let m = players.len();
            if m < 2 {
                return;
            }

            let mut next_mask = 0usize;
            let mut i = 0;
            let mut j = m - 1;
            while i < j {
                let a = players[i];
                let b = players[j];
                if a == first && b == second {
                    *earliest = (*earliest).min(round);
                    *latest = (*latest).max(round);
                    return;
                }
                if a == first || a == second {
                    next_mask |= 1 << a;
                } else if b == first || b == second {
                    next_mask |= 1 << b;
                } else {
                    next_mask |= 1 << a;
                }
                i += 1;
                j -= 1;
            }
            if m % 2 == 1 {
                next_mask |= 1 << players[m / 2];
            }
            dfs(next_mask, round + 1, n, first, second, earliest, latest);
        }

        dfs((1 << n) - 1, 1, n, first, second, &mut earliest, &mut latest);
        vec![earliest, latest]
    }
}