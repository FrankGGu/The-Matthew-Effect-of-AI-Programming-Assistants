class Solution {
public:
    int maximumDifference(vector<int>& nums) {
        int minNum = nums[0], maxDiff = -1;
        for (int i = 1; i < nums.size(); i++) {
            if (nums[i] > minNum) {
                maxDiff = max(maxDiff, nums[i] - minNum);
            } else {
                minNum = nums[i];
            }
        }
        return maxDiff;
    }
};