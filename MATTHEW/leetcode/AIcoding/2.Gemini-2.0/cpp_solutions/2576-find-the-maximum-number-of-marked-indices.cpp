#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maxMarkedIndices(vector<int>& nums) {
        sort(nums.begin(), nums.end());
        int n = nums.size();
        int left = 0;
        int right = (n + 1) / 2;
        int count = 0;
        while (left < n / 2 && right < n) {
            if (2 * nums[left] <= nums[right]) {
                count += 2;
                left++;
                right++;
            } else {
                right++;
            }
        }
        return count;
    }
};