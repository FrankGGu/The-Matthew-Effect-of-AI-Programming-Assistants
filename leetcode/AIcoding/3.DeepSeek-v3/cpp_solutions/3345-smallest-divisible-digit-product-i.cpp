class Solution {
public:
    int smallestDigitProduct(int num) {
        if (num == 0) return 10;
        if (num < 10) return num;

        vector<int> digits;
        for (int i = 9; i >= 2; --i) {
            while (num % i == 0) {
                digits.push_back(i);
                num /= i;
            }
        }

        if (num != 1) return -1;

        sort(digits.begin(), digits.end());
        int result = 0;
        for (int d : digits) {
            result = result * 10 + d;
        }

        return result;
    }
};