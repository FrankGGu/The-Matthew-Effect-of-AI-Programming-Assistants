#include <vector>
#include <numeric>
#include <algorithm>

class Solution {
public:
    long long calculate_time(const std::vector<int>& piles, int k) {
        long long total_time = 0;
        for (int pile : piles) {
            total_time += (pile + k - 1) / k;
        }
        return total_time;
    }

    int minEatingSpeed(std::vector<int>& piles, int h) {
        int max_pile = 0;
        for (int pile : piles) {
            max_pile = std::max(max_pile, pile);
        }

        int low = 1;
        int high = max_pile;
        int ans = max_pile;

        while (low <= high) {
            int mid = low + (high - low) / 2;
            if (calculate_time(piles, mid) <= h) {
                ans = mid;
                high = mid - 1;
            } else {
                low = mid + 1;
            }
        }
        return ans;
    }
};