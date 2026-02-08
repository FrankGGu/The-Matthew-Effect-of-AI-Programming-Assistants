class Solution {
public:
    int differenceOfSum(vector<int>& nums) {
        int elementSum = accumulate(nums.begin(), nums.end(), 0);
        int digitSum = 0;
        for (int num : nums) {
            while (num > 0) {
                digitSum += num % 10;
                num /= 10;
            }
        }
        return abs(elementSum - digitSum);
    }
};