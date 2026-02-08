#include <string>
#include <unordered_map>
#include <algorithm>

class Solution {
public:
    int minSubstring(string s) {
        int n = s.size();
        int minLength = n + 1;

        for (int i = 0; i < n; ++i) {
            std::unordered_map<char, int> count;
            int maxFreq = 0;

            for (int j = i; j < n; ++j) {
                count[s[j]]++;
                maxFreq = std::max(maxFreq, count[s[j]]);

                if (maxFreq * count.size() == (j - i + 1)) {
                    minLength = std::min(minLength, j - i + 1);
                }
            }
        }

        return minLength == n + 1 ? -1 : minLength;
    }
};