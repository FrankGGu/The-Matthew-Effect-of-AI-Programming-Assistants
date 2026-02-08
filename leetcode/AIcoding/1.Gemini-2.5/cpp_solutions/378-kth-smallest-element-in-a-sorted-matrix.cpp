#include <vector>
#include <algorithm>

class Solution {
public:
    int kthSmallest(std::vector<std::vector<int>>& matrix, int k) {
        int n = matrix.size();
        int low = matrix[0][0];
        int high = matrix[n - 1][n - 1];

        while (low < high) {
            int mid = low + (high - low) / 2;
            int count = 0;
            int r = n - 1; 
            int c = 0;     

            // Count elements less than or equal to mid
            while (r >= 0 && c < n) {
                if (matrix[r][c] <= mid) {
                    count += (r + 1);
                    c++; 
                } else {
                    r--; 
                }
            }

            if (count < k) {
                low = mid + 1;
            } else {
                high = mid;
            }
        }

        return low;
    }
};