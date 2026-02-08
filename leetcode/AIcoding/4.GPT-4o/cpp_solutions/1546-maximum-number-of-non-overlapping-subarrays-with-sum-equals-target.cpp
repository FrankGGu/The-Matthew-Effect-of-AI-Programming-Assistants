class Solution {
public:
    int maxNonOverlapping(vector<int>& nums, int target) {
        unordered_map<int, int> prefixSum;
        prefixSum[0] = 1;
        int count = 0, currSum = 0;

        for (int num : nums) {
            currSum += num;
            if (prefixSum[currSum - target] > 0) {
                count++;
                currSum = 0;
                prefixSum.clear();
                prefixSum[0] = 1;
            }
            prefixSum[currSum]++;
        }

        return count;
    }
};