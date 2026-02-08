#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int purchasePlans(vector<int>& nums, int target) {
        sort(nums.begin(), nums.end());
        int count = 0;
        int left = 0;
        int right = nums.size() - 1;
        while (left < right) {
            if (nums[left] + nums[right] <= target) {
                count = (count + (right - left)) % 1000000007;
                left++;
            } else {
                right--;
            }
        }
        return count;
    }
};