class Solution {
public:
    int maxManhattanDistance(vector<vector<int>>& A, int k) {
        int n = A.size(), m = A[0].size();
        int res = 0;
        for (int i = 0; i < 4; ++i) {
            int sign1 = (i & 1) == 0 ? 1 : -1;
            int sign2 = (i & 2) == 0 ? 1 : -1;
            int maxX = INT_MIN, minX = INT_MAX;
            for (int j = 0; j < n; ++j) {
                for (int l = 0; l < m; ++l) {
                    int value = A[j][l] * sign1 + A[j][l] * sign2;
                    maxX = max(maxX, value);
                    minX = min(minX, value);
                }
            }
            res = max(res, maxX - minX + 2 * k);
        }
        return res;
    }
};