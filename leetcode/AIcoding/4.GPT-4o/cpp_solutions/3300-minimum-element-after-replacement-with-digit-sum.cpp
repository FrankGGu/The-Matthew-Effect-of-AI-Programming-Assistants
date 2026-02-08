class Solution {
public:
    int minimumSum(int num) {
        int digitSum = 0;
        while (num > 0) {
            digitSum += num % 10;
            num /= 10;
        }
        return digitSum < 10 ? digitSum : minimumSum(digitSum);
    }
};