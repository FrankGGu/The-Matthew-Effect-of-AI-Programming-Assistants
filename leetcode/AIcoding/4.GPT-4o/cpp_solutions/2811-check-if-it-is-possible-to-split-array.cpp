class Solution {
public:
    bool canSplitArray(vector<int>& nums, int m) {
        if (nums.size() < 2) return true;
        int count = 0;
        for (int i = 1; i < nums.size(); ++i) {
            if (nums[i - 1] + nums[i] >= m) {
                count++;
            }
        }
        return count >= nums.size() - 1;
    }
};