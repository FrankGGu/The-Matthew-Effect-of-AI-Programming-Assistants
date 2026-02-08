class Solution {
public:
    int maxContainers(vector<int>& A, int K) {
        sort(A.begin(), A.end());
        int cnt = 0, sum = 0;
        for (int i = 0; i < A.size(); ++i) {
            sum += A[i];
            if (sum > K) break;
            cnt++;
        }
        return cnt;
    }
};