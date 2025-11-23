#include <vector>
#include <algorithm>
#include <map>
#include <tuple>

using namespace std;

class Solution {
public:
    int P1_orig_idx; // 0-indexed original position of firstPlayer
    int P2_orig_idx; // 0-indexed original position of secondPlayer

    // Memoization table: (current_num_players, f_current_idx, s_current_idx) -> (min_rounds, max_rounds)
    map<tuple<int, int, int>, pair<int, int>> memo;

    pair<int, int> solve(int n_curr, int f_curr_idx, int s_curr_idx) {
        // Base case: firstPlayer and secondPlayer are paired in this round
        if (f_curr_idx + s_curr_idx == n_curr - 1) {
            return {0, 0}; // 0 more rounds from this state, as they meet now
        }

        // Memoization check
        if (memo.count({n_curr, f_curr_idx, s_curr_idx})) {
            return memo[{n_curr, f_curr_idx, s_curr_idx}];
        }

        int min_rounds_res = 1e9; // Initialize with a large value
        int max_rounds_res = -1e9; // Initialize with a small value

        // Determine the number of matches in different regions relative to f_curr_idx and s_curr_idx
        // f_curr_idx and s_curr_idx are 0-indexed positions among current players.
        // Matches are (0, n_curr-1), (1, n_curr-2), ...
        // The match index for a player at position `p` is `min(p, n_curr - 1 - p)`.
        int f_match_idx = min(f_curr_idx, n_curr - 1 - f_curr_idx);
        int s_match_idx = min(s_curr_idx, n_curr - 1 - s_curr_idx);

        // Number of matches entirely to the left of f_curr_idx's match
        int num_matches_before_f = f_match_idx;
        // Number of matches entirely between f_curr_idx's match and s_curr_idx's match
        int num_matches_between_f_s = s_match_idx - f_match_idx - 1;
        // Number of matches entirely to the right of s_curr_idx's match
        int num_matches_after_s = (n_curr / 2) - s_match_idx - 1;

        // Calculate the total number of players in the next round
        int next_n_total = (n_curr + 1) / 2;

        // Calculate the number of "other" winners needed for the next round
        // These are winners from matches not involving firstPlayer or secondPlayer.
        // next_n_total = (winners from matches before f) + 1 (for f) + (winners from matches between f and s) + 1 (for s) + (winners from matches after s) + (1 if middle player exists and is not f or s)
        // So, (winners from matches before f) + (winners from matches between f and s) + (winners from matches after s) = next_n_total - 2 - (1 if middle player exists and is not f or s)
        int target_other_winners_sum = next_n_total - 2; // 2 for f and s

        // Handle the middle player if n_curr is odd
        if (n_curr % 2 == 1) {
            int mid_player_actual_idx = n_curr / 2; // 0-indexed position of the middle player
            // If the middle player is not firstPlayer or secondPlayer, they count as an "other" winner
            if (mid_player_actual_idx != f_curr_idx && mid_player_actual_idx != s_curr_idx) {
                target_other_winners_sum--;
            }
        }

        // Iterate over all possible combinations of winners from the three regions
        // w_left: number of winners from matches before f's match
        // w_between: number of winners from matches between f's and s's matches
        // w_right: number of winners from matches after s's match
        for (int w_left = 0; w_left <= num_matches_before_f; ++w_left) {
            for (int w_between = 0; w_between <= num_matches_between_f_s; ++w_between) {
                // Calculate w_right based on the target sum
                int w_right = target_other_winners_sum - w_left - w_between;

                // Check if w_right is valid (within its allowed range)
                if (w_right >= 0 && w_right <= num_matches_after_s) {
                    // Calculate the new 0-indexed positions of firstPlayer and secondPlayer in the next round
                    int next_f_idx = w_left;
                    int next_s_idx = w_left + 1 + w_between; // +1 for firstPlayer surviving

                    // Adjust next_f_idx and next_s_idx if the middle player (if any) is to their left
                    if (n_curr % 2 == 1) {
                        int mid_player_actual_idx = n_curr / 2;
                        if (mid_player_actual_idx < f_curr_idx) {
                            next_f_idx++;
                            next_s_idx++;
                        } else if (mid_player_actual_idx > f_curr_idx && mid_player_actual_idx < s_curr_idx) {
                            next_s_idx++;
                        }
                    }

                    // Recursive call for the next round
                    pair<int, int> res = solve(next_n_total, next_f_idx, next_s_idx);
                    min_rounds_res = min(min_rounds_res, 1 + res.first);
                    max_rounds_res = max(max_rounds_res, 1 + res.second);
                }
            }
        }

        return memo[{n_curr, f_curr_idx, s_curr_idx}] = {min_rounds_res, max_rounds_res};
    }

    vector<int> earliestAndLatest(int n, int firstPlayer, int secondPlayer) {
        P1_orig_idx = firstPlayer - 1; // Convert to 0-indexed
        P2_orig_idx = secondPlayer - 1; // Convert to 0-indexed

        // Ensure P1_orig_idx < P2_orig_idx for consistent state representation
        if (P1_orig_idx > P2_orig_idx) {
            swap(P1_orig_idx, P2_orig_idx);
        }

        // Initial call to solve with all players, and the initial 0-indexed positions
        pair<int, int> result = solve(n, P1_orig_idx, P2_orig_idx);
        return {result.first, result.second};
    }
};