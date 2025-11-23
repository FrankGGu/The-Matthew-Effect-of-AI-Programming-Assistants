class Solution {
public:
    int minOperations(vector<int>& nums) {
        int n = nums.size();
        if (n <= 1) return 0;

        int diff = nums[1] - nums[0];
        for (int i = 2; i < n; ++i) {
            if (nums[i] - nums[i-1] != diff) {
                return -1;
            }
        }

        return 0;
    }
};