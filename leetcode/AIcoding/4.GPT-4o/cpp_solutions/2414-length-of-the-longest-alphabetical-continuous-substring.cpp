class Solution {
public:
    int longestContinuousSubstring(string s) {
        int maxLength = 1, currentLength = 1;
        for (int i = 1; i < s.size(); i++) {
            if (s[i] == s[i - 1] + 1) {
                currentLength++;
            } else {
                currentLength = 1;
            }
            maxLength = max(maxLength, currentLength);
        }
        return maxLength;
    }
};