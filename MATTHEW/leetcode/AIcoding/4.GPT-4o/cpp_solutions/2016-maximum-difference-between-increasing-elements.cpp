class Solution {
public:
    int maximumDifference(vector<int>& nums) {
        int maxDiff = -1;
        int minElement = nums[0];
        for (int i = 1; i < nums.size(); i++) {
            if (nums[i] > minElement) {
                maxDiff = max(maxDiff, nums[i] - minElement);
            } else {
                minElement = nums[i];
            }
        }
        return maxDiff;
    }
};