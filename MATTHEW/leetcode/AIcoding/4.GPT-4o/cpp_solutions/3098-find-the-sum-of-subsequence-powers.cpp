class Solution {
public:
    int sumOfSubseqWidths(vector<int>& A) {
        sort(A.begin(), A.end());
        long long res = 0, mod = 1e9 + 7, n = A.size();
        for (int i = 0; i < n; ++i) {
            res = (res + (A[i] * (power(2, i) - power(2, n - 1 - i))) % mod + mod) % mod) % mod;
        }
        return res;
    }

private:
    long long power(long long x, long long y) {
        long long res = 1;
        while (y) {
            if (y % 2) res = res * x % (1e9 + 7);
            x = x * x % (1e9 + 7);
            y /= 2;
        }
        return res;
    }
};