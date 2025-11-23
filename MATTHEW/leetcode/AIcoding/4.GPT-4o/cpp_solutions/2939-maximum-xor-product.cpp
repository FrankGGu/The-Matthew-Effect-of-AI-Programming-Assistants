class Solution {
public:
    int maximumXOR(vector<int>& nums) {
        int maxXor = 0;
        for (int num : nums) {
            maxXor |= num;
        }
        return maxXor;
    }
};