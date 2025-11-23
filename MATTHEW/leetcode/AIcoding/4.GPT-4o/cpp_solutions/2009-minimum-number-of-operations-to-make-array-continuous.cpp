class Solution {
public:
    int minOperations(vector<int>& A) {
        sort(A.begin(), A.end());
        int n = A.size(), left = 0, result = n;

        for (int right = 0; right < n; ++right) {
            while (A[right] - A[left] > n - 1) {
                left++;
            }
            result = min(result, n - (right - left + 1));
        }

        return result;
    }
};