#include <vector>

using namespace std;

class Solution {
public:
    int numSubarraysWithSum(vector<int>& nums, int goal) {
        int n = nums.size();
        int count = 0;
        int sum = 0;
        vector<int> prefixSumCount(n + 1, 0);
        prefixSumCount[0] = 1;

        for (int i = 0; i < n; ++i) {
            sum += nums[i];
            if (sum >= goal) {
                count += prefixSumCount[sum - goal];
            }
            prefixSumCount[sum]++;
        }

        return count;
    }
};