class Solution {
public:
    int minOperations(vector<int>& nums, int x) {
        int total = accumulate(nums.begin(), nums.end(), 0);
        int target = total - x;
        if (target < 0) return -1;

        int maxLength = -1, currSum = 0;
        unordered_map<int, int> sumIndex;
        sumIndex[0] = -1;

        for (int i = 0; i < nums.size(); i++) {
            currSum += nums[i];
            if (sumIndex.find(currSum - target) != sumIndex.end()) {
                maxLength = max(maxLength, i - sumIndex[currSum - target]);
            }
            sumIndex[currSum] = i;
        }

        return maxLength == -1 ? -1 : nums.size() - maxLength;
    }
};