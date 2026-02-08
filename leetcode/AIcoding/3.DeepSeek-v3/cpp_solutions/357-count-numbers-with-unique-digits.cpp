class Solution {
public:
    int countNumbersWithUniqueDigits(int n) {
        if (n == 0) return 1;
        int res = 10;
        int uniqueDigits = 9;
        int availableNumbers = 9;
        for (int i = 2; i <= n && availableNumbers > 0; ++i) {
            uniqueDigits *= availableNumbers;
            res += uniqueDigits;
            availableNumbers--;
        }
        return res;
    }
};