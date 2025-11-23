class Solution {
    public int countBalls(int lowLimit, int highLimit) {
        int[] count = new int[46];
        int maxBalls = 0;

        for (int i = lowLimit; i <= highLimit; i++) {
            int sum = 0;
            int temp = i;
            while (temp > 0) {
                sum += temp % 10;
                temp /= 10;
            }
            count[sum]++;
            maxBalls = Math.max(maxBalls, count[sum]);
        }

        return maxBalls;
    }
}