#include <vector>
#include <algorithm>

class Solution {
public:
    int maxChunksToSorted(std::vector<int>& arr) {
        int n = arr.size();
        if (n == 0) {
            return 0;
        }
        if (n == 1) {
            return 1;
        }

        std::vector<int> leftMax(n);
        std::vector<int> rightMin(n);

        leftMax[0] = arr[0];
        for (int i = 1; i < n; ++i) {
            leftMax[i] = std::max(leftMax[i-1], arr[i]);
        }

        rightMin[n-1] = arr[n-1];
        for (int i = n - 2; i >= 0; --i) {
            rightMin[i] = std::min(rightMin[i+1], arr[i]);
        }

        int chunks = 1;
        for (int i = 0; i < n - 1; ++i) {
            if (leftMax[i] <= rightMin[i+1]) {
                chunks++;
            }
        }

        return chunks;
    }
};