class Solution {
public:
    long long minimumReplacement(vector<int>& nums) {
        long long res = 0;
        int n = nums.size();
        int prev = nums[n - 1];
        for (int i = n - 2; i >= 0; --i) {
            if (nums[i] <= prev) {
                prev = nums[i];
                continue;
            }
            int parts = (nums[i] + prev - 1) / prev;
            res += parts - 1;
            prev = nums[i] / parts;
        }
        return res;
    }
};