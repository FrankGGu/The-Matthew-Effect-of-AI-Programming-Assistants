class Solution {
public:
    bool canMakeSubarraySumsZero(vector<int>& nums) {
        int n = nums.size();
        for (int i = 1; i < n; ++i) {
            if (gcd(nums[0], nums[i]) != nums[0]) {
                return false;
            }
        }
        return true;
    }

    int gcd(int a, int b) {
        if (b == 0) {
            return a;
        }
        return gcd(b, a % b);
    }
};