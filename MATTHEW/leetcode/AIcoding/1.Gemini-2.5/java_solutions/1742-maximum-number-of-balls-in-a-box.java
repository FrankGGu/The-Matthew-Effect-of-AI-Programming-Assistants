class Solution {
    public int countBalls(int lowLimit, int highLimit) {
        int[] boxCounts = new int[46]; // Max sum of digits for 99999 is 45. Max sum for 100000 is 1.
        int maxBalls = 0;

        for (int i = lowLimit; i <= highLimit; i++) {
            int num = i;
            int sumDigits = 0;
            while (num > 0) {
                sumDigits += num % 10;
                num /= 10;
            }
            boxCounts[sumDigits]++;
            if (boxCounts[sumDigits] > maxBalls) {
                maxBalls = boxCounts[sumDigits];
            }
        }

        return maxBalls;
    }
}