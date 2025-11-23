class Solution {
public:
    int maximumGood(vector<vector<int>>& statements) {
        int n = statements.size(), maxLength = 0;

        for (int mask = 0; mask < (1 << n); ++mask) {
            vector<int> truth(n);
            bool valid = true;
            for (int i = 0; i < n; ++i) {
                if (mask & (1 << i)) {
                    truth[i] = 1;
                    for (int j = 0; j < n; ++j) {
                        if (statements[i][j] == 1 && truth[j] == 0) {
                            valid = false;
                            break;
                        }
                        if (statements[i][j] == 0 && truth[j] == 1) {
                            valid = false;
                            break;
                        }
                    }
                } else {
                    truth[i] = 0;
                }
                if (!valid) break;
            }
            if (valid) {
                maxLength = max(maxLength, __builtin_popcount(mask));
            }
        }

        return maxLength;
    }
};