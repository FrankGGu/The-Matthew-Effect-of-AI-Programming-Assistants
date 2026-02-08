class Solution {
public:
    int minOperations(vector<int>& nums) {
        int maxNum = 0, operations = 0;
        for (int num : nums) {
            if (num > 0) {
                maxNum = max(maxNum, num);
                operations += __builtin_popcount(num);
            }
        }
        return operations + (maxNum > 0 ? log2(maxNum) : 0);
    }
};