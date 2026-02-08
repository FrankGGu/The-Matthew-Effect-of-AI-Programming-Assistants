class Solution {
public:
    int findDuplicate(vector<int>& nums) {
        int xor_result = 0;
        for (int num : nums) {
            xor_result ^= num;
        }
        return xor_result;
    }
};