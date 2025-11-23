class Solution {
public:
    int differenceOfSums(vector<int>& nums, int x, int y) {
        int sumDivisibleX = 0, sumDivisibleY = 0;
        for (int num : nums) {
            if (num % x == 0) {
                sumDivisibleX += num;
            }
            if (num % y == 0) {
                sumDivisibleY += num;
            }
        }
        return abs(sumDivisibleX - sumDivisibleY);
    }
};