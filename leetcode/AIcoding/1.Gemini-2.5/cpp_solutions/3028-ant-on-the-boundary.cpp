class Solution {
public:
    int returnToBoundaryCount(std::vector<int>& nums) {
        int currentPosition = 0;
        int boundaryReturns = 0;
        for (int move : nums) {
            currentPosition += move;
            if (currentPosition == 0) {
                boundaryReturns++;
            }
        }
        return boundaryReturns;
    }
};