class Solution {
public:
    int countNumbersWithUniqueDigits(int n) {
        if (n == 0) {
            return 1;
        }

        int ans = 10;
        int current_product = 9;
        int available_digits = 9;

        for (int i = 2; i <= n; ++i) {
            current_product *= available_digits;
            ans += current_product;
            available_digits--;
            if (available_digits == 0) {
                break;
            }
        }

        return ans;
    }
};