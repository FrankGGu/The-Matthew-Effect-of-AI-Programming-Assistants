class Solution {
public:
    int maximizeMin(int n, vector<int>& A) {
        sort(A.begin(), A.end());
        int low = 0, high = A[0];
        for (int i = 1; i < n; ++i) {
            high = max(high, A[i]);
        }

        while (low < high) {
            int mid = low + (high - low + 1) / 2;
            if (canAchieve(n, A, mid)) {
                low = mid;
            } else {
                high = mid - 1;
            }
        }

        return low;
    }

    bool canAchieve(int n, vector<int>& A, int x) {
        int count = 0;
        for (int i = 0; i < A.size(); ++i) {
            count += (A[i] / x);
        }
        return count >= n;
    }
};