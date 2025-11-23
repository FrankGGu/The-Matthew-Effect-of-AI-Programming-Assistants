#include <vector>
#include <algorithm>

class Solution {
public:
    bool can_eat_in_time(long long k, const std::vector<int>& piles, int h) {
        long long current_hours = 0;
        for (int pile : piles) {
            current_hours += (pile + k - 1) / k;
            if (current_hours > h) {
                return false;
            }
        }
        return true;
    }

    int minEatingSpeed(std::vector<int>& piles, int h) {
        long long low = 1;
        long long high = 0;
        for (int pile : piles) {
            if (pile > high) {
                high = pile;
            }
        }

        long long ans = high;

        while (low <= high) {
            long long mid = low + (high - low) / 2;
            if (can_eat_in_time(mid, piles, h)) {
                ans = mid;
                high = mid - 1;
            } else {
                low = mid + 1;
            }
        }
        return static_cast<int>(ans);
    }
};