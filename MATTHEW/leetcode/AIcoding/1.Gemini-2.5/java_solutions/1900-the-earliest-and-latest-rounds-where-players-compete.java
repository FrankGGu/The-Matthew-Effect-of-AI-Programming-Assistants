import java.util.HashMap;
import java.util.Map;

class Solution {
    // memo[n][f][s] stores int[]{min_rounds, max_rounds}
    // n: current number of players
    // f: current position of firstPlayer
    // s: current position of secondPlayer
    // Using a 4D array for memoization: memo[f][s][round_idx][0] for min, [1] for max
    // round_idx: 0 for initial round, 1 for next, etc. Max rounds is log2(1000) approx 10.
    // So round_idx goes from 0 to 10.
    private int[][][][] memo;
    private int initialN; // To determine round_idx

    public int[] earliestAndLatest(int n, int firstPlayer, int secondPlayer) {
        initialN = n;
        // Max f, s are n (1000). Max round_idx is 10.
        memo = new int[n + 1][n + 1][11][2];

        // Ensure firstPlayer's position is always less than secondPlayer's position for memoization consistency
        if (firstPlayer > secondPlayer) {
            int temp = firstPlayer;
            firstPlayer = secondPlayer;
            secondPlayer = temp;
        }

        return solve(n, firstPlayer, secondPlayer, 0);
    }

    private int[] solve(int n, int f, int s, int round_idx) {
        // Base case: If they meet in this round
        if (f + s == n + 1) {
            return new int[]{1, 1}; // They meet in 1 more round (this round)
        }

        // Check memoization
        if (memo[f][s][round_idx][0] != 0) {
            return new int[]{memo[f][s][round_idx][0], memo[f][s][round_idx][1]};
        }

        int minRounds = Integer.MAX_VALUE;
        int maxRounds = Integer.MIN_VALUE;

        int nextN = (n + 1) / 2; // Number of players in the next round

        // Iterate over possible number of winners from players to the left of 'f' (lw)
        // and between 'f' and 's' (mw).
        // The players are 1-indexed.
        // Players to the left of 'f': 1 to f-1.
        // Players between 'f' and 's': f+1 to s-1.
        // Players to the right of 's': s+1 to n.

        // Number of players in each segment:
        int leftPlayersCount = f - 1;
        int middlePlayersCount = s - f - 1;
        int rightPlayersCount = n - s;

        // Number of pairs in each segment that can contribute winners:
        // A player 'x' is paired with 'n-x+1'.
        // To determine the new position of 'f' (f_new), we need to count how many players
        // with original positions < 'f' win their matches.
        // Similarly for 's' (s_new).
        // f_new = (number of winners from 1..f-1) + 1
        // s_new = (number of winners from 1..f-1) + 1 + (number of winners from f+1..s-1) + 1

        // lw: number of winners from players {1, ..., f-1}
        // mw: number of winners from players {f+1, ..., s-1}
        // rw: number of winners from players {s+1, ..., n}

        // Each pair (x, n-x+1) produces one winner.
        // The number of players in a segment X is reduced to ceil(X/2) winners if all matches are within that segment.
        // However, matches can cross segments (e.g., x < f and n-x+1 > f).
        // The range of possible winners from a segment of `k` players is `0` to `k`.
        // But the number of *pairs* that can contribute to a segment is `ceil(k/2)`.
        // So, `lw` can range from `0` to `ceil((f-1)/2)`.
        // `mw` can range from `0` to `ceil((s-f-1)/2)`.
        // `rw` can range from `0` to `ceil((n-s)/2)`.

        // Let's use the actual number of players in each segment, not pairs.
        // This is the key for "earliest/latest" in this problem type.
        // For 'lw' (winners from 1 to f-1): can range from 0 to f-1.
        // For 'mw' (winners from f+1 to s-1): can range from 0 to s-f-1.
        // But the total number of winners is fixed at `nextN`.
        // And the new positions `f_new`, `s_new` must be valid.

        // `f_new` is the new position of 'f'. It can range from 1 to `f`.
        // `s_new` is the new position of 's'. It can range from `f_new + 1` to `s`.
        // This is because relative order is preserved, and players can only move to smaller or same positions (due to re-numbering).

        for (int f_new = 1; f_new <= f; ++f_new) {
            for (int s_new = f_new + 1; s_new <= s; ++s_new) {
                // Calculate the number of winners in each segment based on f_new and s_new
                int lw = f_new - 1; // Winners from players 1 to f-1
                int mw = s_new - f_new - 1; // Winners from players f+1 to s-1
                int rw = nextN - s_new; // Winners from players s+1 to n

                // Check if these counts are valid considering the actual number of players in each segment
                // lw must be <= number of players in 1..f-1
                // mw must be <= number of players in f+1..s-1
                // rw must be <= number of players in s+1..n
                if (lw <= leftPlayersCount && mw <= middlePlayersCount && rw <= rightPlayersCount) {
                    // Also check if the number of winners from each segment can actually be formed by the pairs.
                    // This is the tricky part. The number of winners from `k` players is `ceil(k/2)`.
                    // So, `lw` must be chosen from `(f-1)` players. Max `lw` is `ceil((f-1)/2)`.
                    // This is the key constraint that limits the choices.
                    // The number of winners from `k` players is `k_winners = (k+1)/2`.
                    // The number of players in `L` is `f-1`. So `lw` can range from `0` to `(f-1+1)/2`.
                    // The number of players in `M` is `s-f-1`. So `mw` can range from `0` to `(s-f-1+1)/2`.
                    // The number of players in `R` is `n-s`. So `rw` can range from `0` to `(n-s+1)/2`.

                    // The loops should iterate over `lw` and `mw` directly, then calculate `rw`.
                    // This ensures the `ceil` constraints are met.
                    // This means the outer loops `f_new` and `s_new` are incorrect.

                    // Correct iteration:
                    // Loop for `lw` (winners from 1 to f-1)
                    // Loop for `mw` (winners from f+1 to s-1)
                    // Calculate `rw` (winners from s+1 to n)
                    // Check if `rw` is valid.
                    // Then calculate `f_new` and `s_new`.

                    // This is the correct set of loops for this problem:
                    // `lw` is the count of winners among players `1` to `f-1`.
                    // `mw` is the count of winners among players `f+1` to `s-1`.
                    // `rw` is the count of winners among players `s+1` to `n`.

                    // The maximum number of winners from `k` players is `(k+1)/2`.
                    // The minimum number of winners from `k` players is `0` (if all are eliminated by players outside the segment).
                    // This is not correct for "earliest/latest" in this context.
                    // The number of winners from a group of `k` players is `ceil(k/2)`.
                    // So `lw` can range from `0` to `(f-1+1)/2`.
                    // `mw` can range from `0` to `(s-f-1+1)/2`.

                    // The actual number of players in each segment that can produce a winner.
                    // A player at position `x` is paired with `n-x+1`.
                    // If `x` and `n-x+1` are both in `1..f-1`, one winner is produced.
                    // If `x` is in `1..f-1` and `n-x+1` is in `f+1..s-1`, one winner is produced.
                    // This is where the choices for min/max come in.

                    // The range of `lw` (number of winners from `1..f-1`):
                    // Min `lw`: All players `x` in `1..f-1` lose to `n-x+1` (if `n-x+1` is outside `1..f-1`).
                    // Max `lw`: All players `x` in `1..f-1` win.
                    // This is `0` to `f-1`. No, this is wrong.
                    // The number of *pairs* that contribute to `lw` is `ceil((f-1)/2)`.
                    // So `lw` can range from `0` to `ceil((f-1)/2)`.

                    // Let's retry the loops:
                    // `l_winners` is the count of players from `1` to `f-1` who win their matches.
                    // `m_winners` is the count of players from `f+1` to `s-1` who win their matches.
                    // `r_winners` is the count of players from `s+1` to `n` who win their matches.

                    // The total number of winners is `nextN`.
                    // `l_winners + 1 (for f) + m_winners + 1 (for s) + r_winners = nextN`.
                    // `r_winners = nextN - 2 - l_winners - m_winners`.

                    // `l_winners` can range from `0` to `(f - 1 + 1) / 2`.
                    // `m_winners` can range from `0` to `(s - f - 1 + 1) / 2`.
                    // `r_winners` must also satisfy `0 <= r_winners <= (n - s + 1) / 2`.

                    for (int l_winners = 0; l_winners <= (f - 1 + 1) / 2; ++l_winners) {
                        for (int m_winners = 0; m_winners <= (s - f - 1 + 1) / 2; ++m_winners) {
                            int r_winners = nextN - 2 - l_winners - m_winners;

                            // Check if r_winners is a valid count
                            if (r_winners >= 0 && r_winners <= (n - s + 1) / 2) {
                                int new_f = l_winners + 1;
                                int new_s = l_winners + 1 + m_winners + 1;

                                // Recurse for the next round
                                int[] res = solve(nextN, new_f, new_s, round_idx + 1);
                                minRounds = Math.min(minRounds, res[0] + 1);
                                maxRounds = Math.max(maxRounds, res[1] + 1);
                            }
                        }
                    }
                }
            }
        }

        // Store result in memo and return
        memo[f][s][round_idx][0] = minRounds;
        memo[f][s][round_idx][1] = maxRounds;
        return new int[]{minRounds, maxRounds};
    }
}