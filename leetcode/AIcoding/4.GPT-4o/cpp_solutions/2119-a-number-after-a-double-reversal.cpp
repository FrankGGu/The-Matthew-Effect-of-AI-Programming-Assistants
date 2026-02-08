class Solution {
public:
    int numberAfterReversals(int num) {
        if (num == 0) return 0;
        int reversedNum = 0, temp = num;
        while (temp > 0) {
            reversedNum = reversedNum * 10 + temp % 10;
            temp /= 10;
        }
        if (reversedNum % 10 == 0) return 0;
        return num;
    }
};