#include <string>
#include <vector>

class Solution {
public:
    bool canConvertString(std::string s, std::string t, int k) {
        if (s.length() != t.length()) {
            return false;
        }

        std::vector<int> counts(26, 0);

        for (size_t i = 0; i < s.length(); ++i) {
            int diff = (t[i] - s[i] + 26) % 26;
            if (diff == 0) {
                continue;
            }

            long long required_move = (long long)diff + 26LL * counts[diff];
            if (required_move > k) {
                return false;
            }
            counts[diff]++;
        }

        return true;
    }
};