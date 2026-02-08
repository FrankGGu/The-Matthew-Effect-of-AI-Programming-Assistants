class Solution {
    public int countBalls(int lowLimit, int highLimit) {
        int[] counts = new int[46];
        int maxCount = 0;
        for (int i = lowLimit; i <= highLimit; i++) {
            int sum = 0;
            int num = i;
            while (num > 0) {
                sum += num % 10;
                num /= 10;
            }
            counts[sum]++;
            maxCount = Math.max(maxCount, counts[sum]);
        }
        return maxCount;
    }
}