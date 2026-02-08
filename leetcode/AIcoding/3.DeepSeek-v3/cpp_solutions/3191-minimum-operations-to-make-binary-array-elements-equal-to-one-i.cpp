class Solution {
public:
    int minOperations(vector<int>& nums) {
        int n = nums.size();
        int res = 0;
        for (int i = 0; i < n - 1; ++i) {
            if (nums[i] == 0) {
                res++;
                nums[i] ^= 1;
                nums[i + 1] ^= 1;
            }
        }
        return nums.back() == 1 ? res : -1;
    }
};