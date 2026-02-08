#include <vector>
#include <algorithm>

class Solution {
public:
    bool canPlace(int minForce, int m, const std::vector<int>& position) {
        int ballsPlaced = 1;
        int lastPosition = position[0];
        for (int i = 1; i < position.size(); ++i) {
            if (position[i] - lastPosition >= minForce) {
                ballsPlaced++;
                lastPosition = position[i];
                if (ballsPlaced == m) {
                    return true;
                }
            }
        }
        return false;
    }

    int maxDistance(std::vector<int>& position, int m) {
        // The problem statement guarantees 'position' is sorted.
        // std::sort(position.begin(), position.end()); 

        int low = 1; // Minimum possible force is 1
        int high = position.back() - position.front(); // Maximum possible force
        int ans = 0;

        while (low <= high) {
            int mid = low + (high - low) / 2;
            if (canPlace(mid, m, position)) {
                ans = mid;
                low = mid + 1;
            } else {
                high = mid - 1;
            }
        }
        return ans;
    }
};