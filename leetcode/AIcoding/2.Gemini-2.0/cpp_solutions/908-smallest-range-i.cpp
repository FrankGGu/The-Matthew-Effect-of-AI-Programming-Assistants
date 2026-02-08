#include <algorithm>

using namespace std;

class Solution {
public:
    int smallestRangeI(vector<int>& nums, int k) {
        int min_num = nums[0];
        int max_num = nums[0];
        for (int num : nums) {
            min_num = min(min_num, num);
            max_num = max(max_num, num);
        }
        int diff = max_num - min_num;
        return max(0, diff - 2 * k);
    }
};