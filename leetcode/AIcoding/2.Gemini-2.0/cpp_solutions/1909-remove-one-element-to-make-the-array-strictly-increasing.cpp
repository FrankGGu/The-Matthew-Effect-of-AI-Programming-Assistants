#include <vector>

using namespace std;

class Solution {
public:
    bool canBeIncreasing(vector<int>& nums) {
        int n = nums.size();
        int count = 0;
        int prev = nums[0];
        for (int i = 1; i < n; i++) {
            if (nums[i] <= prev) {
                count++;
                if (i > 1 && nums[i] <= nums[i - 2]) {
                    nums[i] = prev;
                }
            } else {
                prev = nums[i];
            }
        }
        return count <= 1;
    }
};