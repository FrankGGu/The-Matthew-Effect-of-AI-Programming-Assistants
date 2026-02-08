class Solution {
public:
    vector<int> finalArrayAfterKMultiplications(vector<int>& A, int K) {
        int n = A.size();
        vector<int> result(n);
        for (int i = 0; i < n; ++i) {
            result[i] = A[i] * (1 << K);
        }
        return result;
    }
};