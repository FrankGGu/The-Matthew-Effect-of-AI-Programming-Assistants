class Solution {
    public int minimumDifference(String num1, String num2) {
        int n = num1.length();
        int[] sum1 = new int[n / 2 + 1];
        int[] sum2 = new int[n / 2 + 1];

        for (int i = 0; i < n / 2; i++) {
            sum1[i + 1] = sum1[i] + (num1.charAt(i) - '0');
            sum2[i + 1] = sum2[i] + (num2.charAt(i) - '0');
        }

        int totalSum = sum1[n / 2] + sum2[n / 2];
        int halfSum = totalSum / 2;
        int target = halfSum - Math.abs(sum1[n / 2] - sum2[n / 2]);

        int minDiff = Integer.MAX_VALUE;
        for (int i = 0; i <= n / 2; i++) {
            for (int j = 0; j <= n / 2; j++) {
                int currentSum = sum1[i] + sum2[j];
                minDiff = Math.min(minDiff, Math.abs(target - currentSum));
            }
        }

        return minDiff;
    }
}