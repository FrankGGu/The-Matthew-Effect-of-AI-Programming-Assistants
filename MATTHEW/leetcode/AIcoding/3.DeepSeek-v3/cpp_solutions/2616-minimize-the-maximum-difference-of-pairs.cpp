#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minimizeMax(vector<int>& nums, int p) {
        sort(nums.begin(), nums.end());
        int left = 0, right = nums.back() - nums.front();
        while (left < right) {
            int mid = left + (right - left) / 2;
            if (canFormPairs(nums, p, mid)) {
                right = mid;
            } else {
                left = mid + 1;
            }
        }
        return left;
    }

private:
    bool canFormPairs(vector<int>& nums, int p, int max_diff) {
        int count = 0;
        for (int i = 0; i < nums.size() - 1 && count < p; ) {
            if (nums[i + 1] - nums[i] <= max_diff) {
                count++;
                i += 2;
            } else {
                i++;
            }
        }
        return count >= p;
    }
};