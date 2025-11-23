class Solution {
public:
    int subarrayLCM(vector<int>& nums, int k) {
        int count = 0;
        int n = nums.size();
        for (int i = 0; i < n; ++i) {
            int current_lcm = nums[i];
            if (current_lcm == k) {
                count++;
            }
            for (int j = i + 1; j < n; ++j) {
                current_lcm = lcm(current_lcm, nums[j]);
                if (current_lcm == k) {
                    count++;
                } else if (current_lcm > k) {
                    break;
                }
            }
        }
        return count;
    }
};