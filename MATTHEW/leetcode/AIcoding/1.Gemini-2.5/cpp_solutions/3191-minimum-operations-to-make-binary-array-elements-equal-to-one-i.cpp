class Solution {
public:
    int minOperations(std::vector<int>& nums) {
        int n = nums.size();
        int operations = 0;

        for (int i = 0; i <= n - 3; ++i) {
            if (nums[i] == 0) {
                operations++;
                // Perform the operation: flip nums[i], nums[i+1], nums[i+2]
                nums[i] = 1 - nums[i];       // 0 becomes 1
                nums[i+1] = 1 - nums[i+1];   // Flip
                nums[i+2] = 1 - nums[i+2];   // Flip
            }
        }

        // After iterating through the array up to n-3,
        // the first n-2 elements (from index 0 to n-3) are guaranteed to be 1.
        // We now need to check the last two elements (at indices n-2 and n-1).
        // If either of them is 0, it's impossible to make them 1,
        // because we can no longer perform an operation that affects them
        // without going out of bounds (an operation at i affects i, i+1, i+2).
        if (nums[n-2] == 0 || nums[n-1] == 0) {
            return -1;
        }

        return operations;
    }
};