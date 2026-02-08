class Solution {
public:
    vector<int> constructArray(int n, int k) {
        vector<int> result(n);
        for (int i = 1; i <= n; ++i) {
            result[i - 1] = i;
        }
        for (int i = 1; i <= k; ++i) {
            if (i % 2 == 1) {
                swap(result[i - 1], result[n - (i / 2)]);
            } else {
                swap(result[i - 1], result[n - (i / 2) - 1]);
            }
        }
        return result;
    }
};