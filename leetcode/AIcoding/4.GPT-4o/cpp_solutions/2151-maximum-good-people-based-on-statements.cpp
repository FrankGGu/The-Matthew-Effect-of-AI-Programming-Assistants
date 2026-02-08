class Solution {
public:
    int maximumGood(vector<vector<int>>& statements) {
        int n = statements.size(), maxGood = 0;
        for (int mask = 0; mask < (1 << n); ++mask) {
            vector<int> good(n, 0);
            bool valid = true;
            for (int i = 0; i < n; ++i) {
                if (mask & (1 << i)) {
                    good[i] = 1;
                    for (int j = 0; j < n; ++j) {
                        if (statements[i][j] == 1 && !(mask & (1 << j))) {
                            valid = false;
                            break;
                        }
                        if (statements[i][j] == 0 && (mask & (1 << j))) {
                            valid = false;
                            break;
                        }
                    }
                }
            }
            if (valid) {
                maxGood = max(maxGood, __builtin_popcount(mask));
            }
        }
        return maxGood;
    }
};