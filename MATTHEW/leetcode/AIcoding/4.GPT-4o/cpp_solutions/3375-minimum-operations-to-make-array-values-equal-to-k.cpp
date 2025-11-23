class Solution {
public:
    int minOperations(vector<int>& nums, int x) {
        int total = accumulate(nums.begin(), nums.end(), 0);
        int target = total - x;
        if (target < 0) return -1;

        int maxLength = 0, currentSum = 0;
        unordered_map<int, int> prefixSums;
        prefixSums[0] = -1;

        for (int i = 0; i < nums.size(); ++i) {
            currentSum += nums[i];
            if (prefixSums.find(currentSum - target) != prefixSums.end()) {
                maxLength = max(maxLength, i - prefixSums[currentSum - target]);
            }
            prefixSums[currentSum] = i;
        }

        return maxLength == 0 ? -1 : nums.size() - maxLength;
    }
};