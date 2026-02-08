#include <vector>

using namespace std;

class Solution {
public:
    long long countSubarrays(vector<int>& nums, int minK, int maxK) {
        long long ans = 0;
        int n = nums.size();
        int minPos = -1, maxPos = -1, leftBound = -1;

        for (int i = 0; i < n; i++) {
            if (nums[i] < minK || nums[i] > maxK) {
                leftBound = i;
                minPos = -1;
                maxPos = -1;
            } else {
                if (nums[i] == minK) {
                    minPos = i;
                }
                if (nums[i] == maxK) {
                    maxPos = i;
                }
                if (minPos != -1 && maxPos != -1) {
                    ans += max(0, min(minPos, maxPos) - leftBound);
                }
            }
        }

        return ans;
    }
};