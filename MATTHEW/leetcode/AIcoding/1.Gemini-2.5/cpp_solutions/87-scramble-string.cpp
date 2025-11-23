#include <string>
#include <vector>
#include <map>
#include <tuple>

class Solution {
public:
    std::map<std::tuple<int, int, int>, bool> memo;

    bool check(const std::string& s1, int i1, const std::string& s2, int i2, int len) {
        if (s1.substr(i1, len) == s2.substr(i2, len)) {
            return true;
        }

        if (len == 1) {
            return false;
        }

        std::tuple<int, int, int> key = {i1, i2, len};
        if (memo.count(key)) {
            return memo[key];
        }

        std::vector<int> counts(26, 0);
        for (int k = 0; k < len; ++k) {
            counts[s1[i1 + k] - 'a']++;
            counts[s2[i2 + k] - 'a']--;
        }
        for (int k = 0; k < 26; ++k) {
            if (counts[k] != 0) {
                memo[key] = false;
                return false;
            }
        }

        for (int k = 1; k < len; ++k) {
            // Case 1: No swap
            if (check(s1, i1, s2, i2, k) && check(s1, i1 + k, s2, i2 + k, len - k)) {
                memo[key] = true;
                return true;
            }

            // Case 2: Swap
            if (check(s1, i1, s2, i2 + len - k, k) && check(s1, i1 + k, s2, i2, len - k)) {
                memo[key] = true;
                return true;
            }
        }

        memo[key] = false;
        return false;
    }

    bool isScramble(std::string s1, std::string s2) {
        if (s1.length() != s2.length()) {
            return false;
        }
        if (s1.empty()) {
            return true;
        }

        memo.clear(); 
        return check(s1, 0, s2, 0, s1.length());
    }
};