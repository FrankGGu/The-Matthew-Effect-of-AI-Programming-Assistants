class Solution {
    public int countNumbersWithUniqueDigits(int n) {
        if (n == 0) {
            return 1;
        }

        int result = 10;
        int currentUniqueDigitsCount = 9;
        int availableDigits = 9;

        for (int i = 2; i <= n; i++) {
            currentUniqueDigitsCount = currentUniqueDigitsCount * availableDigits;
            result += currentUniqueDigitsCount;
            availableDigits--;
        }

        return result;
    }
}