class Solution {
    public int[] missingRolls(int[] rolls, int mean, int n) {
        int m = rolls.length;
        int sum = 0;
        for (int roll : rolls) {
            sum += roll;
        }
        int missingSum = mean * (n + m) - sum;
        if (missingSum < n || missingSum > 6 * n) {
            return new int[0];
        }
        int[] missingRolls = new int[n];
        int quotient = missingSum / n;
        int remainder = missingSum % n;
        for (int i = 0; i < n; i++) {
            missingRolls[i] = quotient;
            if (i < remainder) {
                missingRolls[i]++;
            }
        }
        return missingRolls;
    }
}