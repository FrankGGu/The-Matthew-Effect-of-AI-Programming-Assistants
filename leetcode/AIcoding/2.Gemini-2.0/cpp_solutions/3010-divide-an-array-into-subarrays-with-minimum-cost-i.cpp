#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minimumCost(vector<int>& nums) {
        int n = nums.size();
        vector<int> sorted_nums;
        for (int i = 1; i < n; ++i) {
            sorted_nums.push_back(nums[i]);
        }
        sort(sorted_nums.begin(), sorted_nums.end());
        return nums[0] + sorted_nums[0] + sorted_nums[1];
    }
};