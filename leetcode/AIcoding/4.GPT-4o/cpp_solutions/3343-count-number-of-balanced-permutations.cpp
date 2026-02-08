class Solution {
public:
    int countBalancedPermutations(int n) {
        if (n % 2 != 0) return 0;
        long long res = 1;
        for (int i = 1; i <= n / 2; ++i) {
            res = (res * (2 * i - 1) * (2 * i)) % 1000000007;
        }
        return res;
    }
};