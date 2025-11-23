#include <vector>
#include <algorithm>

class Solution {
public:
    int kthSmallest(std::vector<std::vector<int>>& matrix, int k) {
        int n = matrix.size();
        int low = matrix[0][0];
        int high = matrix[n - 1][n - 1];
        int ans = 0;

        while (low <= high) {
            int mid = low + (high - low) / 2;
            int count = 0;
            int j = n - 1; // Start from the rightmost column

            // Count elements less than or equal to mid
            // For each row, move 'j' left until matrix[i][j] <= mid
            // All elements from matrix[i][0] to matrix[i][j] are <= mid
            for (int i = 0; i < n; ++i) {
                while (j >= 0 && matrix[i][j] > mid) {
                    j--;
                }
                count += (j + 1);
            }

            if (count < k) {
                low = mid + 1;
            } else {
                ans = mid; 
                high = mid - 1;
            }
        }
        return ans;
    }
};