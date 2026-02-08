class Solution {
public:
    int minIncrements(vector<int>& A, vector<int>& target) {
        int n = A.size();
        int res = 0;
        for (int i = 0; i < n; i++) {
            if (A[i] < target[i]) {
                res += target[i] - A[i];
            }
        }
        return res;
    }
};