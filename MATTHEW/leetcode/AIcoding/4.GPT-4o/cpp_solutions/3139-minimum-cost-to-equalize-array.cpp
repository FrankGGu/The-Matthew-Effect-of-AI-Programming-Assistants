class Solution {
public:
    long long minCost(vector<int>& nums) {
        sort(nums.begin(), nums.end());
        long long totalCost = 0;
        long long n = nums.size();

        for (int i = 0; i < n; i++) {
            totalCost += abs(nums[i] - nums[n / 2]);
        }

        return totalCost;
    }
};