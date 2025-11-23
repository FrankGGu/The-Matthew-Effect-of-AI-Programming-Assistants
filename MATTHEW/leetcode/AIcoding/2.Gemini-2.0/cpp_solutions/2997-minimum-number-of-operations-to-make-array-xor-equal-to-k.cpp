class Solution {
public:
    int minOperations(vector<int>& nums, int k) {
        int xorSum = 0;
        for (int num : nums) {
            xorSum ^= num;
        }

        int xorDiff = xorSum ^ k;
        int operations = 0;

        while (xorDiff > 0) {
            operations += (xorDiff & 1);
            xorDiff >>= 1;
        }

        return operations;
    }
};