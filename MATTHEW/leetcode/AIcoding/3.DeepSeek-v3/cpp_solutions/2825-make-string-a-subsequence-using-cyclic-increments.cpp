class Solution {
public:
    bool canMakeSubsequence(string str1, string str2) {
        int n = str1.size(), m = str2.size();
        if (m > n) return false;
        int i = 0, j = 0;
        while (i < n && j < m) {
            char c1 = str1[i];
            char c2 = str2[j];
            if (c1 == c2 || (c1 - 'a' + 1) % 26 + 'a' == c2) {
                j++;
            }
            i++;
        }
        return j == m;
    }
};