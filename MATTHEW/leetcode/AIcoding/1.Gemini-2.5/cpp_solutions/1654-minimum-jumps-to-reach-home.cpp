#include <vector>
#include <queue>
#include <unordered_set>
#include <tuple>
#include <algorithm>

class Solution {
public:
    int minimumJumps(std::vector<int>& forbidden, int a, int b, int x) {
        // A sufficiently large upper bound for positions to explore.
        // Given x, a, b <= 2000.
        // The maximum position to consider is often estimated as max(x, max_forbidden_val) + a + b.
        // Since max(x) is 2000, max(forbidden[i]) is 2000, max(a) is 2000, max(b) is 2000,
        // this gives 2000 + 2000 + 2000 = 6000.
        // A common safe upper bound for such problems is 2 * x + 2 * b, which would be 8000.
        // Using 6000 is usually sufficient for these constraints.
        int MAX_POS = 6000; 

        // If the target is 0, we are already at home.
        if (x == 0) {
            return 0;
        }

        std::unordered_set<int> forbidden_set(forbidden.begin(), forbidden.end());

        // visited[pos][0] stores if position 'pos' has been reached by a forward jump (or initial state).
        // visited[pos][1] stores if position 'pos' has been reached by a backward jump.
        std::vector<std::vector<bool>> visited(MAX_POS + 1, std::vector<bool>(2, false));

        // Queue stores {current_position, jumped_backward_last_flag, num_jumps}
        // jumped_backward_last_flag: 0 if the previous jump was forward (or no jump yet),
        //                            1 if the previous jump was backward.
        std::queue<std::tuple<int, int, int>> q;

        // Initial state: position 0, no previous backward jump (flag 0), 0 jumps.
        q.push({0, 0, 0});
        visited[0][0] = true;

        while (!q.empty()) {
            auto [curr_pos, jumped_backward_last, jumps] = q.front();
            q.pop();

            // Try jumping forward
            int next_pos_f = curr_pos + a;
            // Check if the next forward position is within bounds, not forbidden, and not visited
            if (next_pos_f <= MAX_POS && !forbidden_set.count(next_pos_f) && !visited[next_pos_f][0]) {
                if (next_pos_f == x) {
                    return jumps + 1;
                }
                visited[next_pos_f][0] = true;
                q.push({next_pos_f, 0, jumps + 1});
            }

            // Try jumping backward
            int next_pos_b = curr_pos - b;
            // Can only jump backward if the previous jump was not backward (jumped_backward_last == 0),
            // and the next backward position is non-negative, not forbidden, and not visited.
            if (jumped_backward_last == 0 && next_pos_b >= 0 && !forbidden_set.count(next_pos_b) && !visited[next_pos_b][1]) {
                if (next_pos_b == x) {
                    return jumps + 1;
                }
                visited[next_pos_b][1] = true;
                q.push({next_pos_b, 1, jumps + 1});
            }
        }

        // If the queue becomes empty and the target 'x' has not been reached, it's impossible.
        return -1;
    }
};