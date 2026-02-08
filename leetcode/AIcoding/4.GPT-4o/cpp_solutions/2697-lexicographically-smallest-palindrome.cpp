class Solution {
public:
    string makeSmallestPalindrome(string s) {
        int n = s.size();
        for (int i = 0; i < n / 2; ++i) {
            s[i] = s[n - 1 - i] = min(s[i], s[n - 1 - i]);
        }
        return s;
    }
};