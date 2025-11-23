#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    int longestSubstring(string s, int k) {
        int n = s.length();
        int maxLen = 0;
        vector<int> count(26, 0);

        for (int i = 0; i < n; i++) {
            count[s[i] - 'a']++;
        }

        int left = 0;
        int right = 0;

        while (right < n) {
            if (count[s[right] - 'a'] < k) {
                left = right + 1;
                for (int i = 0; i < 26; i++) {
                    count[i] = 0;
                }
                for (int i = left; i < n; i++) {
                    count[s[i] - 'a']++;
                }
            } else {
                maxLen = max(maxLen, right - left + 1);
            }
            right++;
        }

        return maxLen;
    }
};