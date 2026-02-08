class Solution {
public:
    int maximumXOR(vector<int>& nums) {
        int maxXOR = 0;
        for (int num : nums) {
            maxXOR |= num;
        }
        return maxXOR;
    }
};