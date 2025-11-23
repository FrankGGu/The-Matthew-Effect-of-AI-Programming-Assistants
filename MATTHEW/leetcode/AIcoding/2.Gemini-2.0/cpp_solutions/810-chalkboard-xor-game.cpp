class Solution {
public:
    bool xorGame(vector<int>& nums) {
        int n = nums.size();
        int xorSum = 0;
        for (int num : nums) {
            xorSum ^= num;
        }
        return (xorSum == 0) || (n % 2 == 0);
    }
};