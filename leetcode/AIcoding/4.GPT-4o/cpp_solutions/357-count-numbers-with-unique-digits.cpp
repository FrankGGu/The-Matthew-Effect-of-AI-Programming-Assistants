class Solution {
public:
    int countNumbersWithUniqueDigits(int n) {
        if (n == 0) return 1;
        if (n == 1) return 10;

        int uniqueCount = 10, availableDigits = 9, currentUniqueCount = 9;

        for (int i = 2; i <= n; i++) {
            currentUniqueCount *= availableDigits;
            uniqueCount += currentUniqueCount;
            availableDigits--;
        }

        return uniqueCount;
    }
};