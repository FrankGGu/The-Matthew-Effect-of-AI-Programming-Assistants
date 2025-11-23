class Solution {
public:
    int maximumGood(vector<vector<int>>& statements) {
        int n = statements.size();
        int maxGood = 0;

        for (int mask = 0; mask < (1 << n); ++mask) {
            bool valid = true;
            for (int i = 0; i < n && valid; ++i) {
                if (!(mask & (1 << i))) continue; // i is bad, no need to check
                for (int j = 0; j < n && valid; ++j) {
                    if (statements[i][j] == 2) continue;
                    if ((statements[i][j] == 1) != ((mask & (1 << j)) != 0)) {
                        valid = false;
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