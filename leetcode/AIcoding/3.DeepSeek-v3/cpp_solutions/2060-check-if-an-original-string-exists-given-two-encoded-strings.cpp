class Solution {
public:
    bool possiblyEquals(string s1, string s2) {
        int n1 = s1.size(), n2 = s2.size();
        vector<vector<unordered_set<int>>> memo(n1 + 1, vector<unordered_set<int>>(n2 + 1));
        memo[0][0].insert(0);

        for (int i = 0; i <= n1; ++i) {
            for (int j = 0; j <= n2; ++j) {
                for (int delta : memo[i][j]) {
                    if (i < n1 && isdigit(s1[i])) {
                        int num = 0;
                        for (int k = i; k < n1 && isdigit(s1[k]); ++k) {
                            num = num * 10 + (s1[k] - '0');
                            memo[k + 1][j].insert(delta + num);
                        }
                    }
                    if (j < n2 && isdigit(s2[j])) {
                        int num = 0;
                        for (int k = j; k < n2 && isdigit(s2[k]); ++k) {
                            num = num * 10 + (s2[k] - '0');
                            memo[i][k + 1].insert(delta - num);
                        }
                    }
                    if (i < n1 && !isdigit(s1[i]) && delta < 0) {
                        if (delta + 1 == 0) {
                            memo[i + 1][j].insert(0);
                        } else if (delta + 1 < 0) {
                            memo[i + 1][j].insert(delta + 1);
                        }
                    }
                    if (j < n2 && !isdigit(s2[j]) && delta > 0) {
                        if (delta - 1 == 0) {
                            memo[i][j + 1].insert(0);
                        } else if (delta - 1 > 0) {
                            memo[i][j + 1].insert(delta - 1);
                        }
                    }
                    if (i < n1 && j < n2 && !isdigit(s1[i]) && !isdigit(s2[j]) && delta == 0 && s1[i] == s2[j]) {
                        memo[i + 1][j + 1].insert(0);
                    }
                }
            }
        }

        return memo[n1][n2].count(0);
    }
};