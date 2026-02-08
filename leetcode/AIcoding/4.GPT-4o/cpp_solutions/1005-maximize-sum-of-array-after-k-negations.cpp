class Solution {
public:
    int largestSumAfterKNegations(vector<int>& A, int K) {
        sort(A.begin(), A.end());
        for (int i = 0; i < K; ++i) {
            A[0] = -A[0];
            sort(A.begin(), A.end());
        }
        return accumulate(A.begin(), A.end(), 0);
    }
};