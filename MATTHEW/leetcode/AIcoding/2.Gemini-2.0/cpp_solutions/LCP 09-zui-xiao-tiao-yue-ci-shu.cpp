#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int jump(vector<int>& nums) {
        int n = nums.size();
        if (n <= 1) return 0;

        int jumps = 0;
        int currentReach = 0;
        int maxReach = 0;

        for (int i = 0; i < n - 1; ++i) {
            maxReach = max(maxReach, i + nums[i]);

            if (i == currentReach) {
                jumps++;
                currentReach = maxReach;

                if (currentReach >= n - 1) {
                    return jumps;
                }
            }
        }

        return jumps;
    }
};