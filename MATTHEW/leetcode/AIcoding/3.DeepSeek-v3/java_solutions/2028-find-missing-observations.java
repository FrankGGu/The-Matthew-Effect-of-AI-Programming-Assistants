class Solution {
    public int[] missingRolls(int[] rolls, int mean, int n) {
        int m = rolls.length;
        int sum = mean * (m + n);
        int knownSum = 0;
        for (int roll : rolls) {
            knownSum += roll;
        }
        int missingSum = sum - knownSum;
        if (missingSum < n || missingSum > 6 * n) {
            return new int[0];
        }
        int[] res = new int[n];
        int base = missingSum / n;
        int rem = missingSum % n;
        for (int i = 0; i < n; i++) {
            res[i] = base + (i < rem ? 1 : 0);
        }
        return res;
    }
}