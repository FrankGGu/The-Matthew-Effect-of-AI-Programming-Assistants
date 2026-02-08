class Solution {
public:
    string findTheString(vector<vector<int>>& lcp) {
        int n = lcp.size();
        if (n == 0) return "";
        string res(n, 'a');
        for (int i = 0; i < n; ++i) {
            if (lcp[i][i] != n - i) return "";
            for (int j = i + 1; j < n; ++j) {
                if (lcp[i][j] != lcp[j][i]) return "";
                if (i > 0 && j > 0 && lcp[i-1][j-1] > 0 && lcp[i][j] != lcp[i-1][j-1] - 1) return "";
                if (lcp[i][j] > n - max(i, j)) return "";
                if (res[j] == 'a' && lcp[i][j] > 0) {
                    res[j] = res[i];
                }
            }
        }
        for (int i = 0; i < n; ++i) {
            for (int j = 0; j < n; ++j) {
                int val = 0;
                if (i < n && j < n && res[i] == res[j]) {
                    val = (i + 1 < n && j + 1 < n) ? lcp[i + 1][j + 1] + 1 : 1;
                    val = min(val, n - max(i, j));
                }
                if (lcp[i][j] != val) return "";
            }
        }
        return res;
    }
};