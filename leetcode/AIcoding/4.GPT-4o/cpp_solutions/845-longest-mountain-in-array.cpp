class Solution {
public:
    int longestMountain(vector<int>& A) {
        int n = A.size(), longest = 0;
        for (int i = 1; i < n - 1; ) {
            if (A[i] > A[i - 1] && A[i] > A[i + 1]) {
                int left = i - 1, right = i + 1;
                while (left > 0 && A[left] > A[left - 1]) left--;
                while (right < n - 1 && A[right] > A[right + 1]) right++;
                longest = max(longest, right - left + 1);
                i = right;
            } else {
                i++;
            }
        }
        return longest;
    }
};