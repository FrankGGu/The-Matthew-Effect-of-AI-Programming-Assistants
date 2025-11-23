#include <string>
#include <vector>

class Solution {
public:
    std::string findTheEncryptedString(std::string s, int k) {
        int n = s.length();
        if (n == 0) {
            return "";
        }

        std::string t(n, ' ');

        for (int i = 0; i < n; ++i) {
            int target_idx = (i + k) % n;
            t[target_idx] = s[i];
        }

        return t;
    }
};