class Solution {
public:
    vector<int> findThePrefixCommonArray(vector<int>& A, vector<int>& B) {
        int n = A.size();
        vector<int> result(n);
        vector<int> countA(n + 1, 0), countB(n + 1, 0);

        for (int i = 0; i < n; ++i) {
            countA[A[i]]++;
            countB[B[i]]++;
            result[i] = min(countA[A[i]], countB[A[i]]) + min(countA[B[i]], countB[B[i]]);
        }

        return result;
    }
};