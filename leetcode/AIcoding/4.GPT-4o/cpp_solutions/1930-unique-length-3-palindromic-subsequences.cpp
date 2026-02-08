class Solution {
public:
    int countPalindromicSubseq(string s) {
        int n = s.size();
        unordered_set<string> uniquePalindromes;

        for (int i = 0; i < n; ++i) {
            for (int j = i + 1; j < n; ++j) {
                if (s[i] == s[j]) {
                    for (int k = 0; k < n; ++k) {
                        if (k != i && k != j && s[k] == s[i]) {
                            uniquePalindromes.insert(string() + s[i] + s[k] + s[j]);
                        }
                    }
                }
            }
        }

        return uniquePalindromes.size();
    }
};