class Solution {
public:
    int sumIndicesWithKSetBits(vector<int>& A, int K) {
        int sum = 0;
        for (int i = 0; i < A.size(); ++i) {
            if (__builtin_popcount(i) == K) {
                sum += A[i];
            }
        }
        return sum;
    }
};