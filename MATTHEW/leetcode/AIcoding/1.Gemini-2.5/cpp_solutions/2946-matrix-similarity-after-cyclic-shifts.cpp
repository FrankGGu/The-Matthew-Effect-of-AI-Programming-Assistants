#include <vector>

class Solution {
public:
    bool areSimilar(std::vector<std::vector<int>>& mat, int k) {
        int m = mat.size();
        int n = mat[0].size();

        int effective_k = k % n;

        for (int i = 0; i < m; ++i) {
            if (i % 2 == 0) { // Even row (0-indexed)
                // Check if row is equal to itself after cyclically shifting right by k
                for (int j = 0; j < n; ++j) {
                    if (mat[i][j] != mat[i][(j - effective_k + n) % n]) {
                        return false;
                    }
                }
            } else { // Odd row (0-indexed)
                // Check if row is equal to itself after cyclically shifting left by k
                for (int j = 0; j < n; ++j) {
                    if (mat[i][j] != mat[i][(j + effective_k) % n]) {
                        return false;
                    }
                }
            }
        }

        return true;
    }
};