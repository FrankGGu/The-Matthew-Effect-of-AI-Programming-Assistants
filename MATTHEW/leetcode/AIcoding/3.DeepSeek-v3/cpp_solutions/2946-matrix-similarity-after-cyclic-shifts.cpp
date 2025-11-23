class Solution {
public:
    bool areSimilar(vector<vector<int>>& mat, int k) {
        int m = mat.size();
        int n = mat[0].size();
        k %= n;
        if (k == 0) return true;

        for (int i = 0; i < m; ++i) {
            vector<int> original = mat[i];
            vector<int> shifted(n);
            if (i % 2 == 0) {
                // Left shift
                for (int j = 0; j < n; ++j) {
                    shifted[(j - k + n) % n] = original[j];
                }
            } else {
                // Right shift
                for (int j = 0; j < n; ++j) {
                    shifted[(j + k) % n] = original[j];
                }
            }
            if (shifted != mat[i]) {
                return false;
            }
        }
        return true;
    }
};