class Solution {
public:
    vector<int> prevPermOpt1(vector<int>& A) {
        int n = A.size();
        int i = n - 2;
        while (i >= 0 && A[i] <= A[i + 1]) {
            i--;
        }
        if (i >= 0) {
            int j = n - 1;
            while (A[j] >= A[i]) {
                j--;
            }
            while (j > 0 && A[j] == A[j - 1]) {
                j--;
            }
            swap(A[i], A[j]);
        }
        return A;
    }
};