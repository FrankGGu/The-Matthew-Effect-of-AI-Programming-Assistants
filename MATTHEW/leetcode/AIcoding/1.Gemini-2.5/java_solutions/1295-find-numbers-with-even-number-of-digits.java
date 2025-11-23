class Solution {
    public int findNumbers(int[] nums) {
        int evenDigitNumbersCount = 0;
        for (int num : nums) {
            int numberOfDigits = 0;
            int tempNum = num;
            while (tempNum > 0) {
                tempNum /= 10;
                numberOfDigits++;
            }

            if (numberOfDigits % 2 == 0) {
                evenDigitNumbersCount++;
            }
        }
        return evenDigitNumbersCount;
    }
}