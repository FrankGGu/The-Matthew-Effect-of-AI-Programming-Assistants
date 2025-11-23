class Solution {
public:
    int minOperations(vector<int>& nums) {
        int n = nums.size();
        int res = 0;
        int flip = 0;
        for (int i = 0; i < n; ++i) {
            if ((nums[i] + flip) % 2 == 0) {
                res++;
                flip ^= 1;
            }
        }
        return res;
    }
};