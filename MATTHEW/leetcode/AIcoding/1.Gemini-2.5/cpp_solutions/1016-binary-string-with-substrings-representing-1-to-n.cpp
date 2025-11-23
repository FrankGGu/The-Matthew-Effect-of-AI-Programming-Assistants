#include <string>
#include <vector>
#include <algorithm>
#include <bitset>

class Solution {
public:
    bool queryString(std::string s, int n) {
        std::unordered_set<int> found;
        int s_len = s.length();
        for (int i = 0; i < s_len; ++i) {
            if (s[i] == '0') {
                continue;
            }
            long long current_num = 0;
            for (int j = i; j < s_len; ++j) {
                current_num = (current_num << 1) | (s[j] - '0');
                if (current_num > n) {
                    break;
                }
                found.insert(static_cast<int>(current_num));
            }
        }

        for (int i = 1; i <= n; ++i) {
            if (found.find(i) == found.end()) {
                return false;
            }
        }

        return true;
    }
};