class Solution {
public:
    int minDominoRotations(vector<int>& A, vector<int>& B) {
        int n = A.size();
        int candidates[] = {A[0], B[0]};
        for (int x : candidates) {
            int countA = 0, countB = 0, countEqual = 0;
            for (int i = 0; i < n; i++) {
                if (A[i] == x) countA++;
                else if (B[i] == x) countB++;
                else break;
                if (A[i] == x && B[i] == x) countEqual++;
            }
            if (countA + countB + countEqual == n) {
                return n - max(countA, countB);
            }
        }
        return -1;
    }
};