class Solution {
public:
    int largestOverlap(vector<vector<int>>& A, vector<vector<int>>& B) {
        int n = A.size(), maxOverlap = 0;
        vector<int> shifts(2 * n - 1);

        for (int x = 0; x < n; ++x) {
            for (int y = 0; y < n; ++y) {
                if (A[x][y]) {
                    for (int dx = 0; dx < n; ++dx) {
                        for (int dy = 0; dy < n; ++dy) {
                            if (B[dx][dy]) {
                                int shiftX = dx - x + n - 1;
                                int shiftY = dy - y + n - 1;
                                shifts[shiftX * n + shiftY]++;
                                maxOverlap = max(maxOverlap, shifts[shiftX * n + shiftY]);
                            }
                        }
                    }
                }
            }
        }

        return maxOverlap;
    }
};