class Solution {
public:
    int reverse(int n) {
        int reversed_n = 0;
        while (n > 0) {
            int digit = n % 10;
            reversed_n = reversed_n * 10 + digit;
            n /= 10;
        }
        return reversed_n;
    }

    bool sumOfNumberAndReverse(int num) {
        if (num == 0) {
            return true;
        }

        for (int x = 0; x <= num; ++x) {
            if (x + reverse(x) == num) {
                return true;
            }
        }
        return false;
    }
};