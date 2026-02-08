#include <vector>
#include <algorithm>

class Solution {
public:
    bool canJump(std::vector<int>& nums) {
        int n = nums.size();

        if (n == 1) {
            return true;
        }

        int max_reach = 0;
        for (int i = 0; i < n; ++i) {
            if (i > max_reach) {
                return false;
            }

            max_reach = std::max(max_reach, i + nums[i]);

            if (max_reach >= n - 1) {
                return true;
            }
        }

        // This part of the code should theoretically not be reached.
        // If the loop completes, it means max_reach was always sufficient
        // to cover the current index, and eventually max_reach would have
        // become >= n-1, triggering a 'return true' inside the loop.
        // If it somehow completes without returning true, it implies
        // max_reach never reached n-1, which would mean it's false.
        // However, given the problem constraints and logic, a return
        // will always happen within the loop.
        return false; // Fallback, though should be unreachable.
    }
};