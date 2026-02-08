class Solution {
    public int[] missingRolls(int[] rolls, int mean, int m) {
        int n = rolls.length;
        long sumRolls = 0;
        for (int roll : rolls) {
            sumRolls += roll;
        }

        long totalSumRequired = (long) (n + m) * mean;
        long sumMissing = totalSumRequired - sumRolls;

        if (sumMissing < m * 1 || sumMissing > m * 6) {
            return new int[0];
        }

        int[] result = new int[m];
        int baseValue = (int) (sumMissing / m);
        int remainder = (int) (sumMissing % m);

        for (int i = 0; i < m; i++) {
            if (i < remainder) {
                result[i] = baseValue + 1;
            } else {
                result[i] = baseValue;
            }
        }

        return result;
    }
}