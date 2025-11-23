class Solution {
public:
    int minDeletionSize(vector<string>& A) {
        int n = A.size(), m = A[0].size();
        vector<bool> deleteColumn(m, false);
        int count = 0;

        for (int j = 0; j < m; ++j) {
            for (int i = 1; i < n; ++i) {
                if (deleteColumn[j]) break;
                if (A[i][j] < A[i - 1][j]) {
                    deleteColumn[j] = true;
                    count++;
                }
            }
        }

        return count;
    }
};