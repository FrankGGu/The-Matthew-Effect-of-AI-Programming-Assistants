class Solution {
public:
    int minOperations(vector<int>& nums) {
        int operations = 0;
        for (int num : nums) {
            int remainder = num % 3;
            if (remainder == 1 || remainder == 2) {
                operations += (3 - remainder) < remainder ? (3 - remainder) : remainder;
            }
        }
        return operations;
    }
};