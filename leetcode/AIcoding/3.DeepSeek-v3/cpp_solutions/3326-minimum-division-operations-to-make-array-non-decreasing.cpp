class Solution {
public:
    int minimumOperations(vector<int>& nums) {
        int n = nums.size();
        if (n <= 1) return 0;

        int operations = 0;
        for (int i = 1; i < n; ++i) {
            if (nums[i] < nums[i-1]) {
                operations++;
                nums[i] = nums[i-1];
            }
        }
        return operations;
    }
};