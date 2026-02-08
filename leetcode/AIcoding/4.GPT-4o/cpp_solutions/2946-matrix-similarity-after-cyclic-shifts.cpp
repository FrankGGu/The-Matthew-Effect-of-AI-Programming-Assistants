class Solution {
public:
    bool areSimilar(vector<vector<int>>& A, vector<vector<int>>& B) {
        int n = A.size(), m = A[0].size();
        vector<int> countA(101, 0), countB(101, 0);

        for (int i = 0; i < n; ++i) {
            for (int j = 0; j < m; ++j) {
                countA[A[i][j]]++;
                countB[B[i][j]]++;
            }
        }

        for (int i = 0; i < 101; i++) {
            if (countA[i] != countB[i]) return false;
        }

        return true;
    }
};