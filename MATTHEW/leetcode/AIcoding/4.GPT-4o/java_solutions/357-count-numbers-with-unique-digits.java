class Solution {
    public int countNumbersWithUniqueDigits(int n) {
        if (n == 0) return 1;
        if (n == 1) return 10;

        int count = 10;
        int uniqueDigits = 9;
        int availableNumbers = 9;

        for (int i = 2; i <= n; i++) {
            uniqueDigits *= availableNumbers;
            count += uniqueDigits;
            availableNumbers--;
        }

        return count;
    }
}