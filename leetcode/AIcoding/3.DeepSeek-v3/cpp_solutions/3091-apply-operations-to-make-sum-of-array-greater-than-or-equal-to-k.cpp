class Solution {
public:
    int minOperations(int k) {
        int res = INT_MAX;
        for (int a = 1; a <= k; ++a) {
            int b = (k + a - 1) / a - 1;
            res = min(res, a + b);
            if (a > b) break;
        }
        return res;
    }
};