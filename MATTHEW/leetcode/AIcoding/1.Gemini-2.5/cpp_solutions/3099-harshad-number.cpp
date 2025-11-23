class Solution {
public:
    int sumOfTheDigitsOfHarshadNumber(int x) {
        int original_x = x;
        int sum_digits = 0;
        while (x > 0) {
            sum_digits += x % 10;
            x /= 10;
        }

        if (original_x % sum_digits == 0) {
            return sum_digits;
        } else {
            return -1;
        }
    }
};