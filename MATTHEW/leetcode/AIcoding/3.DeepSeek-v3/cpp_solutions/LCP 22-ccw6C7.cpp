class Solution {
public:
    int paintingPlan(int n, int k) {
        if (k == n * n) return 1;
        int res = 0;
        for (int i = 0; i <= n; ++i) {
            for (int j = 0; j <= n; ++j) {
                if (i * n + j * n - i * j == k) {
                    res += comb(n, i) * comb(n, j);
                }
            }
        }
        return res;
    }

private:
    int comb(int n, int m) {
        if (m == 0) return 1;
        long long res = 1;
        for (int i = 1; i <= m; ++i) {
            res = res * (n - m + i) / i;
        }
        return (int)res;
    }
};