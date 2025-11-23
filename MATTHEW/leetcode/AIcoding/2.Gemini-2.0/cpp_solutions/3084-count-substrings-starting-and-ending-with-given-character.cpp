class Solution {
public:
    long long countSubstrings(string s, char c) {
        long long count = 0;
        int n = s.length();
        for (int i = 0; i < n; ++i) {
            if (s[i] == c) {
                for (int j = i; j < n; ++j) {
                    if (s[j] == c) {
                        count++;
                    }
                }
            }
        }
        return count;
    }
};