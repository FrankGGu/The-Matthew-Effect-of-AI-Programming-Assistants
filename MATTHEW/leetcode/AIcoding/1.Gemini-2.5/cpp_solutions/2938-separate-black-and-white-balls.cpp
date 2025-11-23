#include <string>

class Solution {
public:
    long long minimumSteps(std::string s) {
        long long ans = 0;
        int ones_count = 0;
        for (char c : s) {
            if (c == '1') {
                ones_count++;
            } else {
                ans += ones_count;
            }
        }
        return ans;
    }
};