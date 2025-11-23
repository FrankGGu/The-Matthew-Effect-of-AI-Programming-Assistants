#include <vector>

using namespace std;

class Solution {
public:
    bool check(vector<int>& nums) {
        int n = nums.size();
        if (n <= 1) return true;

        for (int i = 0; i < n - 1; ++i) {
            if (nums[i] >= nums[i + 1]) {
                return false;
            }
        }
        return true;
    }
};