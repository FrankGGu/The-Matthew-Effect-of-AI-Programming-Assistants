#include <string>

class Solution {
public:
    int countHomogenous(std::string s) {
        int mod = 1e9 + 7;
        long long res = 0;
        int current_streak = 0;
        for (int i = 0; i < s.length(); ++i) {
            if (i > 0 && s[i] == s[i-1]) {
                current_streak++;
            } else {
                current_streak = 1;
            }
            res = (res + current_streak) % mod;
        }
        return res;
    }
};