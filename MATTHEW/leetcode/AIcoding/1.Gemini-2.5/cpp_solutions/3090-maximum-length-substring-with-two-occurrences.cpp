#include <string>
#include <vector>
#include <algorithm>

class Solution {
public:
    int maximumLengthSubstring(std::string s) {
        std::vector<int> freq(26, 0);
        int left = 0;
        int maxLength = 0;
        int n = s.length();

        for (int right = 0; right < n; ++right) {
            freq[s[right] - 'a']++;

            while (freq[s[right] - 'a'] > 2) {
                freq[s[left] - 'a']--;
                left++;
            }

            maxLength = std::max(maxLength, right - left + 1);
        }

        return maxLength;
    }
};