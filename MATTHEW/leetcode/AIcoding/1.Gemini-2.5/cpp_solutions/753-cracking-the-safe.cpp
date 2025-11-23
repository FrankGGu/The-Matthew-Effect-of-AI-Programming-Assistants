#include <string>
#include <vector>
#include <unordered_set>
#include <cmath>
#include <algorithm>

class Solution {
public:
    std::string crackSafe(int n, int k) {
        std::string ans = std::string(n, '0');
        std::unordered_set<std::string> visited;
        visited.insert(ans);

        int total_passwords = 1;
        for (int i = 0; i < n; ++i) {
            total_passwords *= k;
        }

        for (int i = 0; i < total_passwords - 1; ++i) {
            std::string prefix = ans.substr(ans.length() - n + 1);
            for (int j = k - 1; j >= 0; --j) {
                std::string next_pass = prefix + std::to_string(j);
                if (visited.find(next_pass) == visited.end()) {
                    visited.insert(next_pass);
                    ans += std::to_string(j);
                    break;
                }
            }
        }
        return ans;
    }
};