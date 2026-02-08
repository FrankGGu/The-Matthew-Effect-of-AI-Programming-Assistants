#include <string>
#include <algorithm>
#include <vector>

class Solution {
public:
    bool canMakeEqual(std::string s, int k) {
        int n = s.length();
        if (n == 0) {
            return true;
        }

        int start_fixed_index = std::max(0, n - k);

        if (start_fixed_index >= n) {
            return true;
        }

        char target = s[start_fixed_index];
        for (int i = start_fixed_index + 1; i < n; ++i) {
            if (s[i] != target) {
                return false;
            }
        }

        return true;
    }
};