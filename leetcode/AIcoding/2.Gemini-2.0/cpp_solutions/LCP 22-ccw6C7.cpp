class Solution {
public:
    int paintingPlan(int n, int k) {
        if (k < 0 || k > n * n) return 0;
        if (n == 0) return k == 0 ? 1 : 0;
        if (n == 1) return k <= 1 ? 1 : 0;

        int count = 0;
        for (int i = 0; i <= n; ++i) {
            for (int j = 0; j <= n; ++j) {
                if (i * n + j * n - i * j == k) {
                    long long c1 = 1, c2 = 1;
                    if (i > n || i < 0 || j > n || j < 0) continue;
                    if (i > 0) {
                        for (int p = 0; p < i; ++p) {
                            c1 = c1 * (n - p) / (p + 1);
                        }
                    } else if (i != 0 && i != n) {
                        c1 = 0;
                    }

                    if (j > 0) {
                        for (int p = 0; p < j; ++p) {
                            c2 = c2 * (n - p) / (p + 1);
                        }
                    } else if (j != 0 && j != n) {
                        c2 = 0;
                    }

                    count += c1 * c2;
                }
            }
        }
        return count;
    }
};