#include <vector>
#include <queue>
#include <set>
#include <utility> // For std::pair

class Solution {
public:
    int minimumOperations(std::vector<int>& nums, int start, int goal) {
        std::queue<std::pair<int, int>> q; // Stores {current_number, operations_count}
        std::set<int> visited; // Stores visited numbers

        q.push({start, 0});
        visited.insert(start);

        while (!q.empty()) {
            int current_num = q.front().first;
            int steps = q.front().second;
            q.pop();

            if (current_num == goal) {
                return steps;
            }

            for (int n : nums) {
                // Operation 1: x + n
                int next_num_plus = current_num + n;
                if (next_num_plus == goal) {
                    return steps + 1;
                }
                if (visited.find(next_num_plus) == visited.end()) {
                    visited.insert(next_num_plus);
                    q.push({next_num_plus, steps + 1});
                }

                // Operation 2: x - n
                int next_num_minus = current_num - n;
                if (next_num_minus == goal) {
                    return steps + 1;
                }
                if (visited.find(next_num_minus) == visited.end()) {
                    visited.insert(next_num_minus);
                    q.push({next_num_minus, steps + 1});
                }

                // Operation 3: x ^ n
                int next_num_xor = current_num ^ n;
                if (next_num_xor == goal) {
                    return steps + 1;
                }
                if (visited.find(next_num_xor) == visited.end()) {
                    visited.insert(next_num_xor);
                    q.push({next_num_xor, steps + 1});
                }
            }
        }

        return -1; // Goal is unreachable
    }
};