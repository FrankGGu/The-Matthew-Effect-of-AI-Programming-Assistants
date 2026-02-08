#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minimumDeletions(vector<int>& nums) {
        int n = nums.size();
        int min_val = nums[0], max_val = nums[0];
        int min_index = 0, max_index = 0;

        for (int i = 1; i < n; ++i) {
            if (nums[i] < min_val) {
                min_val = nums[i];
                min_index = i;
            }
            if (nums[i] > max_val) {
                max_val = nums[i];
                max_index = i;
            }
        }

        int left = min(min_index, max_index);
        int right = max(min_index, max_index);

        return min({right + 1, n - left, left + 1 + n - right});
    }
};