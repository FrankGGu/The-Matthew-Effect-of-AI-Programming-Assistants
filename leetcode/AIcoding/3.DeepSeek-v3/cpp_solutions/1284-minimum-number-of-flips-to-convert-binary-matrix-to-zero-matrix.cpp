class Solution {
public:
    int minFlips(vector<vector<int>>& mat) {
        int m = mat.size(), n = mat[0].size();
        int res = INT_MAX;
        for (int mask = 0; mask < (1 << (m * n)); ++mask) {
            auto temp = mat;
            int cnt = 0;
            for (int i = 0; i < m * n; ++i) {
                if (mask & (1 << i)) {
                    int x = i / n, y = i % n;
                    flip(temp, x, y, m, n);
                    cnt++;
                }
            }
            if (isZero(temp)) {
                res = min(res, cnt);
            }
        }
        return res == INT_MAX ? -1 : res;
    }

    void flip(vector<vector<int>>& mat, int x, int y, int m, int n) {
        mat[x][y] ^= 1;
        if (x - 1 >= 0) mat[x - 1][y] ^= 1;
        if (x + 1 < m) mat[x + 1][y] ^= 1;
        if (y - 1 >= 0) mat[x][y - 1] ^= 1;
        if (y + 1 < n) mat[x][y + 1] ^= 1;
    }

    bool isZero(vector<vector<int>>& mat) {
        for (auto& row : mat) {
            for (int num : row) {
                if (num != 0) return false;
            }
        }
        return true;
    }
};