#include <string>
#include <algorithm>

class Solution {
public:
    int countBinarySubstrings(std::string s) {
        if (s.length() <= 1) {
            return 0;
        }

        int ans = 0;
        int prevCount = 0;
        int currentCount = 1;

        for (int i = 1; i < s.length(); ++i) {
            if (s[i] == s[i-1]) {
                currentCount++;
            } else {
                ans += std::min(prevCount, currentCount);
                prevCount = currentCount;
                currentCount = 1;
            }
        }
        ans += std::min(prevCount, currentCount);

        return ans;
    }
};