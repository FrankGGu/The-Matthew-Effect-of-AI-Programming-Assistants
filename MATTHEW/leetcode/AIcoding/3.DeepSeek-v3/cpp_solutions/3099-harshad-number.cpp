class Solution {
public:
    int sumOfTheDigitsOfHarshadNumber(int x) {
        if (x == 0) return -1;
        int original = x;
        int sum = 0;
        while (x > 0) {
            sum += x % 10;
            x /= 10;
        }
        if (original % sum == 0) {
            return sum;
        } else {
            return -1;
        }
    }
};