#include <string>
#include <queue>
#include <unordered_set>
#include <algorithm> // For std::min

class Solution {
public:
    std::string findLexSmallestString(std::string s, int a, int b) {
        int n = s.length();
        std::string min_s = s;
        std::queue<std::string> q;
        std::unordered_set<std::string> visited;

        q.push(s);
        visited.insert(s);

        while (!q.empty()) {
            std::string curr_s = q.front();
            q.pop();

            min_s = std::min(min_s, curr_s);

            // Operation 1: Add 'a' to all digits at odd indices
            std::string next_s_add = curr_s;
            for (int i = 1; i < n; i += 2) {
                next_s_add[i] = ((next_s_add[i] - '0' + a) % 10) + '0';
            }
            if (visited.find(next_s_add) == visited.end()) {
                visited.insert(next_s_add);
                q.push(next_s_add);
            }

            // Operation 2: Rotate the string by 'b' positions
            // Ensure b is within bounds and apply modulo for effective rotation
            int effective_b = b % n;
            std::string next_s_rotate = curr_s.substr(n - effective_b) + curr_s.substr(0, n - effective_b);
            if (visited.find(next_s_rotate) == visited.end()) {
                visited.insert(next_s_rotate);
                q.push(next_s_rotate);
            }
        }

        return min_s;
    }
};