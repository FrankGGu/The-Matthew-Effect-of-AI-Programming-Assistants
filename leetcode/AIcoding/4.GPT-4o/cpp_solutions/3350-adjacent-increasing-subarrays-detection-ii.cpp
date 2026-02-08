class Solution {
public:
    bool containsAdjacentIncreasing(vector<int>& nums) {
        for (int i = 1; i < nums.size(); ++i) {
            if (nums[i] > nums[i - 1]) {
                return true;
            }
        }
        return false;
    }
};