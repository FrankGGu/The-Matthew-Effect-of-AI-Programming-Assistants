#include <vector>
#include <algorithm>
#include <numeric>

class Solution {
public:
    int maxIncreasingGroups(std::vector<int>& usageLimits) {
        std::sort(usageLimits.begin(), usageLimits.end());

        long long groups_formed = 0;
        long long current_available_items = 0;

        for (int i = 0; i < usageLimits.size(); ++i) {
            current_available_items += usageLimits[i];

            // We have i+1 distinct types of items available (from index 0 to i).
            // We can form at most i+1 groups using these types of items.
            // The next group to form would be of length (groups_formed + 1).
            // This group needs (groups_formed + 1) distinct items.
            // So, (groups_formed + 1) must be <= (i + 1).
            // Also, we must have enough total items: current_available_items >= (groups_formed + 1).
            while (groups_formed + 1 <= i + 1 && current_available_items >= groups_formed + 1) {
                groups_formed++;
                current_available_items -= groups_formed; // Spend items for the newly formed group
            }
        }

        return static_cast<int>(groups_formed);
    }
};