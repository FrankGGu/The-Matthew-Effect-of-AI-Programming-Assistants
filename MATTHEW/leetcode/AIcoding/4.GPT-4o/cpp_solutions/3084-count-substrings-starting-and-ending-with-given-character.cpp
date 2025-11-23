class Solution {
public:
    int countSubstrings(string s, char c) {
        int count = 0;
        int n = s.size();
        for (int i = 0; i < n; ++i) {
            if (s[i] == c) {
                count += (i + 1) * (n - i);
            }
        }
        return count;
    }
};