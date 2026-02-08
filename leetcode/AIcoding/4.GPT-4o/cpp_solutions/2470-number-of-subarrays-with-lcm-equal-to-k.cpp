class Solution {
public:
    int subarrayLCM(vector<int>& nums, int k) {
        int count = 0;
        int n = nums.size();

        for (int i = 0; i < n; ++i) {
            int lcm = 1;
            for (int j = i; j < n; ++j) {
                lcm = (lcm * nums[j]) / gcd(lcm, nums[j]);
                if (lcm > k) break;
                if (lcm == k) count++;
            }
        }

        return count;
    }
};