#include <string>
#include <algorithm>
#include <vector>

using namespace std;

class Solution {
public:
    int characterReplacement(string s, int k) {
        int n = s.length();
        int left = 0;
        int right = 0;
        int maxLen = 0;
        vector<int> count(26, 0);
        int maxCount = 0;

        while (right < n) {
            count[s[right] - 'A']++;
            maxCount = max(maxCount, count[s[right] - 'A']);

            while (right - left + 1 - maxCount > k) {
                count[s[left] - 'A']--;
                left++;
            }

            maxLen = max(maxLen, right - left + 1);
            right++;
        }

        return maxLen;
    }
};