#include <vector>
#include <string>
#include <unordered_set>

class Solution {
public:
    std::string shortestUncommonSubstring(std::vector<std::string>& A) {
        std::unordered_set<std::string> set(A.begin(), A.end());
        for (int len = 1; len <= 10; ++len) {
            for (int i = 0; i < (1 << len); ++i) {
                std::string candidate;
                for (int j = 0; j < len; ++j) {
                    candidate += (i & (1 << j)) ? 'a' : 'b';
                }
                if (set.find(candidate) == set.end()) {
                    return candidate;
                }
            }
        }
        return "";
    }
};