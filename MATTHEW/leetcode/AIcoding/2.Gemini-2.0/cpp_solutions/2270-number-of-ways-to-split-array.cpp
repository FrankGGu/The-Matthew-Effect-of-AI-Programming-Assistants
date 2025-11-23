#include <vector>

using namespace std;

class Solution {
public:
    int waysToSplitArray(vector<int>& nums) {
        long long totalSum = 0;
        for (int num : nums) {
            totalSum += num;
        }

        long long currentSum = 0;
        int count = 0;
        for (int i = 0; i < nums.size() - 1; ++i) {
            currentSum += nums[i];
            if (currentSum >= totalSum - currentSum) {
                count++;
            }
        }

        return count;
    }
};