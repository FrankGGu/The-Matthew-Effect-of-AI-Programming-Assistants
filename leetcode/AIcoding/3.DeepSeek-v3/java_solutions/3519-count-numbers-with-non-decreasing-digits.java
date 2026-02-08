class Solution {
    public int countNumbersWithUniqueDigits(int n) {
        if (n == 0) return 1;
        int res = 10;
        int uniqueDigits = 9;
        int availableNumber = 9;
        for (int i = 2; i <= n && availableNumber > 0; i++) {
            uniqueDigits *= availableNumber;
            res += uniqueDigits;
            availableNumber--;
        }
        return res;
    }
}