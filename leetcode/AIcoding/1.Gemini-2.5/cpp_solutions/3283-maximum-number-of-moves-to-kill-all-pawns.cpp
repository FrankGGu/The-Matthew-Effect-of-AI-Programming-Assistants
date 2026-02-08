#include <vector>
#include <algorithm>

class Solution {
public:
    int maximumMoves(std::vector<int>& nums) {
        int n = nums.size();
        int start_idx = -1;

        for (int i = 0; i < n; ++i) {
            if (nums[i] == -1) {
                start_idx = i;
                break;
            }
        }

        int max_pawns_killed = 0;

        int current_pawns_left = 0;
        for (int i = start_idx - 1; i >= 0; --i) {
            if (nums[i] == 1) {
                current_pawns_left++;
            } else if (nums[i] == 0) {
                break;
            }
        }
        max_pawns_killed = std::max(max_pawns_killed, current_pawns_left);

        int current_pawns_right = 0;
        for (int i = start_idx + 1; i < n; ++i) {
            if (nums[i] == 1) {
                current_pawns_right++;
            } else if (nums[i] == 0) {
                break;
            }
        }
        max_pawns_killed = std::max(max_pawns_killed, current_pawns_right);

        return max_pawns_killed;
    }
};