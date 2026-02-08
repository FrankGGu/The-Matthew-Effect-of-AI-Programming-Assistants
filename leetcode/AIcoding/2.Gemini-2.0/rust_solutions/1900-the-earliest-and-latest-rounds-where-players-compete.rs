impl Solution {
    pub fn earliest_and_latest(n: i32, first_player: i32, second_player: i32) -> Vec<i32> {
        fn solve(n: i32, first: i32, second: i32, round: i32, min_round: &mut i32, max_round: &mut i32) {
            if first == second {
                *min_round = round.min(*min_round);
                *max_round = round.max(*max_round);
                return;
            }
            if (first + 1 == second) && (second == (n + 1) / 2 + 1) && (n % 2 == 0) {
                *min_round = round.min(*min_round);
                *max_round = round.max(*max_round);
                return;
            }
            for i in 1..=(n + 1) / 2 {
                for j in (i + 1)..=n / 2 + 1 {
                    let new_first = if first <= i {
                        (i + 1 + 1) / 2
                    } else if first <= n - j + 1 {
                        (n / 2 + 1 + 1) / 2
                    } else {
                        n - j / 2
                    };

                    let new_second = if second <= i {
                        (i + 1 + 1) / 2
                    } else if second <= n - j + 1 {
                        (n / 2 + 1 + 1) / 2
                    } else {
                        n - j / 2
                    };

                    let new_n = (n + 1) / 2;
                    solve(new_n, new_first, new_second, round + 1, min_round, max_round);
                }
            }

            if n == 1 {
                *min_round = round.min(*min_round);
                *max_round = round.max(*max_round);
            }
        }

        let mut min_round = i32::MAX;
        let mut max_round = i32::MIN;
        solve(n, first_player, second_player, 1, &mut min_round, &mut max_round);
        vec![min_round, max_round]
    }
}