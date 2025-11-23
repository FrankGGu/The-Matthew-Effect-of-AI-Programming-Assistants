class Solution {
public:
    int minOperations(vector<int>& nums, int k) {
        int n = nums.size();
        int sum = accumulate(nums.begin(), nums.end(), 0);
        if (sum < k) return -1;

        int operations = 0;
        for (int i = 0; i < n; ++i) {
            if (sum >= k) return operations;
            sum += nums[i];
            operations++;
        }
        return operations;
    }
};