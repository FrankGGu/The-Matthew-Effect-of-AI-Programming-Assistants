class Solution {
public:
    string longestPalindrome(string s) {
        int n = s.size();
        if (n < 2) return s;
        int start = 0, maxLength = 1;

        for (int i = 0; i < n; ++i) {
            // Check for odd length palindromes
            int low = i, high = i;
            while (low >= 0 && high < n && s[low] == s[high]) {
                if (high - low + 1 > maxLength) {
                    start = low;
                    maxLength = high - low + 1;
                }
                low--;
                high++;
            }

            // Check for even length palindromes
            low = i, high = i + 1;
            while (low >= 0 && high < n && s[low] == s[high]) {
                if (high - low + 1 > maxLength) {
                    start = low;
                    maxLength = high - low + 1;
                }
                low--;
                high++;
            }
        }

        return s.substr(start, maxLength);
    }
};