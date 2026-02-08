class Solution {
public:
    int sumOfDigits(int num) {
        int sum = 0;
        while (num > 0) {
            sum += num % 10;
            num /= 10;
        }
        return sum;
    }

    int minimumSum(int num) {
        int minSum = num;
        while (num >= 10) {
            num = sumOfDigits(num);
            if (num < minSum) {
                minSum = num;
            }
        }
        return minSum;
    }
};