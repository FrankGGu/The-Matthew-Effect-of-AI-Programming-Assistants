#include <string>
#include <algorithm>
#include <vector>

using namespace std;

class Solution {
public:
    int characterReplacement(string s, int k) {
        int n = s.length();
        int maxLength = 0;
        vector<int> charCounts(26, 0);
        int maxCount = 0;
        int start = 0;

        for (int end = 0; end < n; ++end) {
            charCounts[s[end] - 'A']++;
            maxCount = max(maxCount, charCounts[s[end] - 'A']);

            while (end - start + 1 - maxCount > k) {
                charCounts[s[start] - 'A']--;
                start++;
            }

            maxLength = max(maxLength, end - start + 1);
        }

        return maxLength;
    }
};