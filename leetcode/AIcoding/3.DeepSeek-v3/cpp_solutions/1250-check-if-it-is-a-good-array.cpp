class Solution {
public:
    bool isGoodArray(vector<int>& nums) {
        int gcd_val = nums[0];
        for (int num : nums) {
            gcd_val = __gcd(gcd_val, num);
            if (gcd_val == 1) {
                return true;
            }
        }
        return gcd_val == 1;
    }
};