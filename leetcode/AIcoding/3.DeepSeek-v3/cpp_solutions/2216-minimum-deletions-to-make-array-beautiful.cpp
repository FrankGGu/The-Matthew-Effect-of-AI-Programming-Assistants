class Solution {
public:
    int minDeletion(vector<int>& nums) {
        int n = nums.size();
        int res = 0;
        for (int i = 0; i < n - 1; ) {
            if (nums[i] == nums[i + 1]) {
                res++;
                i++;
            } else {
                i += 2;
            }
        }
        if ((n - res) % 2 != 0) {
            res++;
        }
        return res;
    }
};