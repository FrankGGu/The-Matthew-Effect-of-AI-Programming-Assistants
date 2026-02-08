class Solution {
public:
    int subarrayGCD(vector<int>& nums, int k) {
        int count = 0;
        int n = nums.size();

        for (int i = 0; i < n; ++i) {
            int gcd = 0;
            for (int j = i; j < n; ++j) {
                gcd = __gcd(gcd, nums[j]);
                if (gcd < k) break;
                if (gcd == k) count++;
            }
        }

        return count;
    }
};