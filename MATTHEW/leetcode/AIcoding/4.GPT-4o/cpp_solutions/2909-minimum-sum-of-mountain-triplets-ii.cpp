class Solution {
public:
    int minimumSum(vector<int>& nums) {
        sort(nums.begin(), nums.end());
        int n = nums.size();
        int minSum = INT_MAX;

        for (int i = 0; i < n; i++) {
            int sum = 0;
            sum += nums[i];
            int left = (i - 1 + n) % n;
            int right = (i + 1) % n;
            sum += nums[left];
            sum += nums[right];
            minSum = min(minSum, sum);
        }

        return minSum;
    }
};