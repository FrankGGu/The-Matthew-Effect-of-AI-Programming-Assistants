class Solution {
public:
    int minOperations(vector<int>& nums) {
        int n = nums.size();
        sort(nums.begin(), nums.end());
        int median = nums[n / 2];
        int operations = 0;
        for (int num : nums) {
            operations += abs(num - median);
        }
        return operations;
    }
};