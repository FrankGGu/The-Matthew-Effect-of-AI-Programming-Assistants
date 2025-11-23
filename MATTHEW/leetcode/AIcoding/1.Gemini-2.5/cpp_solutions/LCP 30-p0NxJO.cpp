#include <vector>
#include <algorithm>

class Solution {
public:
    long long magicTower(std::vector<int>& nums) {
        long long total_sum = 0;
        for (int x : nums) {
            total_sum += x;
        }

        if (total_sum < 0) {
            return -1;
        }

        long long current_health_needed = 1; // Represents the minimum health required *after* exiting the current room.
                                            // Initially, it's the minimum health required after the last room (which is 1).

        for (int i = nums.size() - 1; i >= 0; --i) {
            // Calculate the minimum health required *before* entering room i.
            // This health must be enough to survive room i AND meet `current_health_needed` for the next stage.
            // So, (health_before_room_i + nums[i]) >= current_health_needed
            // health_before_room_i >= current_health_needed - nums[i]
            // Also, health_before_room_i must be at least 1.
            current_health_needed = std::max(1LL, current_health_needed - nums[i]);
        }

        return current_health_needed;
    }
};