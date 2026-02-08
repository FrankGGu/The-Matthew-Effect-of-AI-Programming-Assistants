class Solution {
public:
    int minOperations(vector<int>& nums, int x) {
        int target = accumulate(nums.begin(), nums.end(), 0) - x;
        if (target < 0) return -1;

        int maxLength = -1, currentSum = 0;
        unordered_map<int, int> prefixSum{{0, -1}};

        for (int i = 0; i < nums.size(); ++i) {
            currentSum += nums[i];
            if (prefixSum.count(currentSum - target)) {
                maxLength = max(maxLength, i - prefixSum[currentSum - target]);
            }
            prefixSum[currentSum] = i;
        }

        return maxLength == -1 ? -1 : nums.size() - maxLength;
    }
};