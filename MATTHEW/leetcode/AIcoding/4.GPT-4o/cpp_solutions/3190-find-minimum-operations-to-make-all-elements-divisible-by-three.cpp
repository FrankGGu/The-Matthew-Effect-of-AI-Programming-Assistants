class Solution {
public:
    int minOperations(vector<int>& nums) {
        int count = 0;
        for (int num : nums) {
            int remainder = num % 3;
            if (remainder == 1) {
                count += 1;
            } else if (remainder == 2) {
                count += 2;
            }
        }
        return count;
    }
};