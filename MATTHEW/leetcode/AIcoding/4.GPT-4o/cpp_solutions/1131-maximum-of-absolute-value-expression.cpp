class Solution {
public:
    int maxAbsValExpr(vector<int>& A, vector<int>& B) {
        int n = A.size();
        int maxVal = 0;
        for (int i = 0; i < 4; ++i) {
            int signA = (i & 1) ? 1 : -1;
            int signB = (i & 2) ? 1 : -1;
            int currentMax = 0;
            for (int j = 0; j < n; ++j) {
                currentMax = max(currentMax, signA * A[j] + signB * B[j]);
            }
            maxVal = max(maxVal, currentMax);
        }
        return maxVal;
    }
};