class Solution {
public:
    int longestSemiRepetitiveSubstring(string s) {
        int n = s.size();
        int maxLength = 1, start = 0, repeatCount = 0;

        for (int end = 1; end < n; end++) {
            if (s[end] == s[end - 1]) {
                repeatCount++;
            }

            while (repeatCount > 1) {
                if (s[start] == s[start + 1]) {
                    repeatCount--;
                }
                start++;
            }

            maxLength = max(maxLength, end - start + 1);
        }

        return maxLength;
    }
};