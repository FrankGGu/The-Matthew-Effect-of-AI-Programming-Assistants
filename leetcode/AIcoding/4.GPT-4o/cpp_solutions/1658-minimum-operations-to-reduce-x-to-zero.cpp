class Solution {
public:
    int minOperations(vector<int>& nums, int x) {
        int total = accumulate(nums.begin(), nums.end(), 0);
        int target = total - x;
        if (target < 0) return -1;

        int maxLength = -1, currentSum = 0;
        unordered_map<int, int> sumIndex;
        sumIndex[0] = -1;

        for (int i = 0; i < nums.size(); ++i) {
            currentSum += nums[i];
            if (sumIndex.find(currentSum - target) != sumIndex.end()) {
                maxLength = max(maxLength, i - sumIndex[currentSum - target]);
            }
            sumIndex[currentSum] = i;
        }

        return maxLength == -1 ? -1 : nums.size() - maxLength;
    }
};