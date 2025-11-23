class Solution {
public:
    int maximumLength(string s) {
        int n = s.size();
        vector<vector<int>> cnt(26, vector<int>(n + 2, 0));

        for (int i = 0; i < n; ) {
            int j = i;
            while (j < n && s[j] == s[i]) {
                j++;
            }
            int len = j - i;
            for (int l = 1; l <= len; l++) {
                cnt[s[i] - 'a'][l] += len - l + 1;
            }
            i = j;
        }

        int res = -1;
        for (int c = 0; c < 26; c++) {
            for (int l = n; l >= 1; l--) {
                if (cnt[c][l] >= 3) {
                    res = max(res, l);
                    break;
                }
            }
        }
        return res;
    }
};