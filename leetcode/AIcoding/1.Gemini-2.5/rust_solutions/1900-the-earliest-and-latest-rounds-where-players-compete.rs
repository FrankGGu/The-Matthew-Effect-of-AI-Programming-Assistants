use std::collections::HashMap;
use std::cmp::{min, max};

struct Solution;

impl Solution {
    pub fn earliest_and_latest(n: i32, first_player: i32, second_player: i32) -> Vec<i32> {
        let mut memo: HashMap<(i32, i32, i32), (i32, i32)> = HashMap::new();

        // Ensure first_player < second_player for consistent state
        let (p1, p2) = if first_player < second_player {
            (first_player, second_player)
        } else {
            (second_player, first_player)
        };

        let result = Self::dfs(n, p1, p2, &mut memo);
        vec![result.0, result.1]
    }

    fn dfs(n: i32, p1: i32, p2: i32, memo: &mut HashMap<(i32, i32, i32), (i32, i32)>) -> (i32, i32) {
        // Base case: If players meet in this round
        // They meet if their positions sum up to n + 1 (1-indexed)
        if p1 + p2 == n + 1 {
            return (1, 1);
        }

        // Check memoization
        if let Some(&res) = memo.get(&(n, p1, p2)) {
            return res;
        }

        let mut min_rounds = i32::MAX;
        let mut max_rounds = i32::MIN;

        // Number of players in the next round
        let next_n = (n + 1) / 2;

        // Determine the "match index" for p1 and p2 in the current round.
        // A player at position `k` (1-indexed) is part of the match `min(k, n - k + 1)`.
        // This `min` value represents the "slot" this match occupies in the new list of players.
        let p1_match_idx = min(p1, n - p1 + 1);
        let p2_match_idx = min(p2, n - p2 + 1);

        // If p1 and p2 are in the same match index, it means they are paired and meet.
        // This case is already covered by the base case `p1 + p2 == n + 1`.
        // If they don't meet, then `p1_match_idx` must be less than `p2_match_idx` (since p1 < p2).

        // Iterate over all possible numbers of winners from matches *before* p1's match slot (`w_left`)
        // and *between* p1's and p2's match slots (`w_mid`).
        // These choices determine the new positions of p1 and p2 in the next round.

        // `w_left_max`: Maximum number of winners from matches before `p1_match_idx`.
        // These matches are `1, 2, ..., p1_match_idx - 1`. So, `p1_match_idx - 1` matches.
        let w_left_max = p1_match_idx - 1;

        // `w_mid_max`: Maximum number of winners from matches between `p1_match_idx` and `p2_match_idx`.
        // These matches are `p1_match_idx + 1, ..., p2_match_idx - 1`. So, `p2_match_idx - p1_match_idx - 1` matches.
        let w_mid_max = p2_match_idx - p1_match_idx - 1;

        for w_left in 0..=w_left_max {
            for w_mid in 0..=w_mid_max {
                // Calculate the new positions of p1 and p2 in the next round based on `w_left` and `w_mid`.
                // `new_p1`: The new position of `p1` is `w_left` (winners before it) + 1 (for p1 itself).
                let new_p1 = w_left + 1;
                // `new_p2`: The new position of `p2` is `w_left` + 1 (for p1) + `w_mid` (winners between them) + 1 (for p2 itself).
                let new_p2 = w_left + 1 + w_mid + 1;

                // Recursively call for the next round with the new number of players and new positions.
                let (sub_min, sub_max) = Self::dfs(next_n, new_p1, new_p2, memo);

                // Update overall min and max rounds
                min_rounds = min(min_rounds, 1 + sub_min);
                max_rounds = max(max_rounds, 1 + sub_max);
            }
        }

        // Store and return the result
        memo.insert((n, p1, p2), (min_rounds, max_rounds));
        (min_rounds, max_rounds)
    }
}