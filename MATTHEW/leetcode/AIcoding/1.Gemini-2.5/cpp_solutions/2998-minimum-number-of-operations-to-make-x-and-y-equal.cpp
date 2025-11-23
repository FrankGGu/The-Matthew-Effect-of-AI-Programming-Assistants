#include <queue>
#include <unordered_map>
#include <algorithm>

class Solution {
public:
    int minimumOperationsToMakeEqual(int x, int y) {
        if (x == y) {
            return 0;
        }

        std::queue<std::pair<int, int>> q;
        std::unordered_map<int, int> visited;

        q.push({x, 0});
        visited[x] = 0;

        while (!q.empty()) {
            int current_val = q.front().first;
            int operations = q.front().second;
            q.pop();

            if (current_val == y) {
                return operations;
            }

            // Operation 1: x = x - 1
            // Ensure next_val is non-negative
            int next_val_minus_1 = current_val - 1;
            if (next_val_minus_1 >= 0) {
                if (visited.find(next_val_minus_1) == visited.end() || visited[next_val_minus_1] > operations + 1) {
                    visited[next_val_minus_1] = operations + 1;
                    q.push({next_val_minus_1, operations + 1});
                }
            }

            // Operation 2: x = x + 1
            // The +1 operation can potentially lead to very large numbers.
            // However, for optimal solutions, if current_val is significantly larger than y,
            // current_val + 1 is generally not useful unless it makes current_val divisible by 5 or 11.
            // The maximum value we might need to explore for division purposes is y + 10 (to make it divisible by 11).
            // So, we can limit the exploration of current_val + 1 to a certain bound, e.g., y + 11.
            // If current_val is less than y, current_val + 1 is a primary way to reach y.
            // The maximum value to visit for current_val + 1 is typically y + 10.
            // If current_val exceeds y + 10, then current_val + 1 is unlikely to be optimal.
            int next_val_plus_1 = current_val + 1;
            if (next_val_plus_1 <= y + 11) { // Heuristic upper bound for +1 operation
                if (visited.find(next_val_plus_1) == visited.end() || visited[next_val_plus_1] > operations + 1) {
                    visited[next_val_plus_1] = operations + 1;
                    q.push({next_val_plus_1, operations + 1});
                }
            }

            // Operation 3: x = x / 5
            if (current_val % 5 == 0) {
                int next_val_div_5 = current_val / 5;
                if (visited.find(next_val_div_5) == visited.end() || visited[next_val_div_5] > operations + 1) {
                    visited[next_val_div_5] = operations + 1;
                    q.push({next_val_div_5, operations + 1});
                }
            }

            // Operation 4: x = x / 11
            if (current_val % 11 == 0) {
                int next_val_div_11 = current_val / 11;
                if (visited.find(next_val_div_11) == visited.end() || visited[next_val_div_11] > operations + 1) {
                    visited[next_val_div_11] = operations + 1;
                    q.push({next_val_div_11, operations + 1});
                }
            }
        }

        // This line should theoretically not be reached if x can always be made equal to y.
        // Given the operations, it's always possible to reach y (e.g., by repeatedly adding/subtracting 1).
        return -1; 
    }
};