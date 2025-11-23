class Solution {
public:
    int rotatedDigits(int n) {
        int count = 0;
        for (int i = 1; i <= n; ++i) {
            if (isGood(i)) {
                count++;
            }
        }
        return count;
    }

private:
    bool isGood(int num) {
        bool hasDifferentDigit = false;
        int temp = num;
        while (temp > 0) {
            int digit = temp % 10;
            if (digit == 3 || digit == 4 || digit == 7) {
                return false;
            }
            if (digit == 2 || digit == 5 || digit == 6 || digit == 9) {
                hasDifferentDigit = true;
            }
            temp /= 10;
        }
        return hasDifferentDigit;
    }
};