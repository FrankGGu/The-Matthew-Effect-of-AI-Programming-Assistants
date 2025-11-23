class Solution {
public:
    bool hasTrailingZeros(vector<int>& nums) {
        int orResult = 0;
        for (int num : nums) {
            orResult |= num;
        }
        return (orResult & 1) == 0;
    }
};