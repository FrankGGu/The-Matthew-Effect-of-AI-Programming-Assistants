class Solution {
public:
    int maxEmployees(vector<int>& A) {
        sort(A.begin(), A.end());
        int n = A.size();
        int maxInvite = 0;

        for (int i = 0; i < n; ++i) {
            if (A[i] <= i) {
                maxInvite = i + 1;
            }
        }

        return maxInvite;
    }
};