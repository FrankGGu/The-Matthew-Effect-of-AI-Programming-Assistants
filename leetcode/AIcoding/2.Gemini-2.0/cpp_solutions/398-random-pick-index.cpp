class Solution {
public:
    vector<int> nums;
    Solution(vector<int>& nums) {
        this->nums = nums;
    }

    int pick(int target) {
        int count = 0;
        int res = -1;
        for (int i = 0; i < nums.size(); ++i) {
            if (nums[i] == target) {
                count++;
                if (rand() % count == 0) {
                    res = i;
                }
            }
        }
        return res;
    }
};