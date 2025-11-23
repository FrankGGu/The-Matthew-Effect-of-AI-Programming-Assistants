#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    long long largestPerimeter(vector<int>& nums) {
        sort(nums.begin(), nums.end());
        long long sum = 0;
        for (int num : nums) {
            sum += num;
        }

        for (int i = nums.size() - 1; i >= 2; --i) {
            sum -= nums[i];
            if (nums[i] < sum) {
                return sum + nums[i];
            }
        }
        return -1;
    }
};