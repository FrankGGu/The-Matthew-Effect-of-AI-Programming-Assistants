class Solution {
public:
    bool canMakeSubsequence(string str1, string str2) {
        int m = str1.size(), n = str2.size();
        int j = 0;

        for (int i = 0; i < m && j < n; i++) {
            if ((str1[i] - 'a' + 1) % 26 == (str2[j] - 'a')) {
                j++;
            }
        }

        return j == n;
    }
};