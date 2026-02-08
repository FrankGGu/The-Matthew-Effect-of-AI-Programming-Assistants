class Solution {
public:
    vector<int> constructArray(int n, int m) {
        vector<int> result(n);
        for (int i = 0; i < n; ++i) {
            result[i] = i + 1;
        }
        if (m == n - 1) {
            return result;
        }
        for (int i = 0; i < m; ++i) {
            if (i % 2 == 0) {
                result[i] = m - i / 2;
            } else {
                result[i] = (i + 1) / 2 + m / 2 + 1;
            }
        }
        return result;
    }
};