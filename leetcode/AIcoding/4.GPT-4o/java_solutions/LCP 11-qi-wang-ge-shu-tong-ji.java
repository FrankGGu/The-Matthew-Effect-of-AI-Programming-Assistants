class Solution {
    public int[] missingRolls(int[] rolls, int mean, int n) {
        int total = mean * (rolls.length + n);
        int currentSum = 0;
        for (int roll : rolls) {
            currentSum += roll;
        }
        int remainingSum = total - currentSum;
        if (remainingSum < n || remainingSum > 6 * n) {
            return new int[0];
        }

        int[] result = new int[n];
        int baseValue = remainingSum / n;
        int extra = remainingSum % n;

        for (int i = 0; i < n; i++) {
            result[i] = baseValue + (i < extra ? 1 : 0);
        }

        return result;
    }
}