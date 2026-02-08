#include <vector>
#include <string>
#include <queue>
#include <unordered_set>

class Solution {
public:
    int openLock(std::vector<std::string>& deadends, std::string target) {
        std::unordered_set<std::string> dead_set(deadends.begin(), deadends.end());
        if (dead_set.count("0000")) {
            return -1;
        }

        std::queue<std::string> q;
        q.push("0000");
        std::unordered_set<std::string> visited;
        visited.insert("0000");

        int level = 0;

        while (!q.empty()) {
            int level_size = q.size();
            for (int i = 0; i < level_size; ++i) {
                std::string current = q.front();
                q.pop();

                if (current == target) {
                    return level;
                }

                for (int j = 0; j < 4; ++j) {
                    // Forward
                    std::string next_f = current;
                    next_f[j] = (current[j] - '0' + 1) % 10 + '0';
                    if (visited.find(next_f) == visited.end() && dead_set.find(next_f) == dead_set.end()) {
                        q.push(next_f);
                        visited.insert(next_f);
                    }

                    // Backward
                    std::string next_b = current;
                    next_b[j] = (current[j] - '0' - 1 + 10) % 10 + '0';
                    if (visited.find(next_b) == visited.end() && dead_set.find(next_b) == dead_set.end()) {
                        q.push(next_b);
                        visited.insert(next_b);
                    }
                }
            }
            level++;
        }

        return -1;
    }
};