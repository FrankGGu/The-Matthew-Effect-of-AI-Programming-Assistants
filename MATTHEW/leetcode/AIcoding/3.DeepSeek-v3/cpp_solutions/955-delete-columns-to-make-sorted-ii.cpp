class Solution {
public:
    int minDeletionSize(vector<string>& strs) {
        int n = strs.size();
        if (n == 0) return 0;
        int m = strs[0].size();
        int res = 0;
        vector<bool> sorted(n - 1, false);

        for (int j = 0; j < m; ++j) {
            bool canDelete = false;
            vector<bool> temp = sorted;
            for (int i = 0; i < n - 1; ++i) {
                if (!sorted[i] && strs[i][j] > strs[i + 1][j]) {
                    canDelete = true;
                    break;
                }
            }
            if (canDelete) {
                res++;
            } else {
                for (int i = 0; i < n - 1; ++i) {
                    if (strs[i][j] < strs[i + 1][j]) {
                        temp[i] = true;
                    }
                }
                sorted = temp;
            }
        }

        return res;
    }
};