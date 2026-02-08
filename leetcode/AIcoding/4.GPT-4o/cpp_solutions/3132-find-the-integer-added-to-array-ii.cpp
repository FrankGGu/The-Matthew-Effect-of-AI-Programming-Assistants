class Solution {
public:
    int findInteger(vector<int>& A) {
        int n = A.size();
        int low = 0, high = n;
        while (low < high) {
            int mid = low + (high - low) / 2;
            if (A[mid] <= mid) {
                low = mid + 1;
            } else {
                high = mid;
            }
        }
        return low;
    }
};