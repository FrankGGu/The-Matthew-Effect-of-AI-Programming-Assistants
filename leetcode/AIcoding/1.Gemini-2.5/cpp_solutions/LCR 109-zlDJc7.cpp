#include <string>
#include <vector>
#include <queue>
#include <unordered_set>
#include <utility> // For std::pair

class Solution {
public:
    int openLock(std::vector<std::string>& deadends, std::string target) {
        std::unordered_set<std::string> dead_set(deadends.begin(), deadends.end());
        std::unordered_set<std::string> visited;
        std::queue<std::pair<std::string, int>> q;

        std::string start_node = "0000";

        if (dead_set.count(start_node)) {
            return -1;
        }

        q.push({start_node, 0});
        visited.insert(start_node);

        while (!q.empty()) {
            std::pair<std::string, int> current = q.front();
            q.pop();
            std::string current_state = current.first;
            int distance = current.second;

            if (current_state == target) {
                return distance;
            }

            for (int i = 0; i < 4; ++i) {
                char original_char = current_state[i];

                // Spin up
                current_state[i] = (original_char == '9') ? '0' : original_char + 1;
                if (!visited.count(current_state) && !dead_set.count(current_state)) {
                    visited.insert(current_state);
                    q.push({current_state, distance + 1});
                }

                // Spin down
                current_state[i] = (original_char == '0') ? '9' : original_char - 1;
                if (!visited.count(current_state) && !dead_set.count(current_state)) {
                    visited.insert(current_state);
                    q.push({current_state, distance + 1});
                }

                // Restore original character for next iteration
                current_state[i] = original_char;
            }
        }

        return -1;
    }
};