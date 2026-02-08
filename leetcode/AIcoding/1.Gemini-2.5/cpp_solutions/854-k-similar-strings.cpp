#include <string>
#include <queue>
#include <unordered_set>
#include <utility>
#include <algorithm>

class Solution {
public:
    int kSimilarity(std::string s1, std::string s2) {
        if (s1 == s2) {
            return 0;
        }

        std::queue<std::pair<std::string, int>> q;
        std::unordered_set<std::string> visited;

        q.push({s1, 0});
        visited.insert(s1);

        int n = s1.length();

        while (!q.empty()) {
            std::string current_s = q.front().first;
            int swaps = q.front().second;
            q.pop();

            if (current_s == s2) {
                return swaps;
            }

            int i = 0;
            while (i < n && current_s[i] == s2[i]) {
                i++;
            }

            for (int j = i + 1; j < n; ++j) {
                // Optimization: Only consider swaps that could potentially fix current_s[i]
                // and where current_s[j] is not already in its correct place.
                if (current_s[j] == s2[i] && current_s[j] != s2[j]) {
                    std::string next_s = current_s;
                    std::swap(next_s[i], next_s[j]);

                    if (visited.find(next_s) == visited.end()) {
                        visited.insert(next_s);
                        q.push({next_s, swaps + 1});
                    }
                }
            }
        }
        return -1; // Should not reach here for valid inputs
    }
};