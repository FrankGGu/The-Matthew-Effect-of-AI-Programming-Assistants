#include <string>
#include <vector>
#include <cmath>

class Solution {
public:
    int countAlmostEqualPairs(std::string s, int k) {
        int n = s.length();
        int count = 0;
        for (int i = 0; i < n; ++i) {
            for (int j = i + 1; j < n; ++j) {
                if (s[i] == s[j] && (j - i) <= k) {
                    count++;
                }
            }
        }
        return count;
    }
};