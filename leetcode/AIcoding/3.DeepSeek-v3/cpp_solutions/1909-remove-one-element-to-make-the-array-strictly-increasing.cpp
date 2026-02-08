class Solution {
public:
    bool canBeIncreasing(vector<int>& nums) {
        int count = 0;
        int index = -1;
        int n = nums.size();

        for (int i = 0; i < n - 1; ++i) {
            if (nums[i] >= nums[i + 1]) {
                count++;
                index = i;
            }
        }

        if (count == 0) {
            return true;
        }

        if (count == 1) {
            if (index == 0 || index == n - 2) {
                return true;
            }
            if (nums[index - 1] < nums[index + 1] || (index + 2 < n && nums[index] < nums[index + 2])) {
                return true;
            }
        }

        return false;
    }
};