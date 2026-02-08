class Solution {
public:
    int maxKDivisibleComponents(int n, vector<int>& A, int K) {
        int count = 0;
        vector<bool> visited(n + 1, false);
        for (int i = 0; i < A.size(); ++i) {
            if (!visited[A[i]] && A[i] % K == 0) {
                count++;
                for (int j = A[i]; j <= n; j += A[i]) {
                    visited[j] = true;
                }
            }
        }
        return count;
    }
};