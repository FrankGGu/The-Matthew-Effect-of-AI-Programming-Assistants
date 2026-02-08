class Solution {
public:
    int sumSubseqWidths(vector<int>& A) {
        sort(A.begin(), A.end());
        long long mod = 1e9 + 7, n = A.size(), result = 0;
        long long pow2 = 1;

        for (int i = 0; i < n; ++i) {
            result = (result + (A[i] * pow2) % mod - (A[i] * pow2 % mod) + mod) % mod;
            pow2 = (pow2 * 2) % mod;
        }

        return result;
    }
};