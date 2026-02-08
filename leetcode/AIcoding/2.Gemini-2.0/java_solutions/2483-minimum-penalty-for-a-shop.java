class Solution {
    public int bestClosingTime(String customers) {
        int n = customers.length();
        int[] prefixSum = new int[n + 1];
        for (int i = 0; i < n; i++) {
            prefixSum[i + 1] = prefixSum[i] + (customers.charAt(i) == 'Y' ? 1 : 0);
        }

        int minPenalty = Integer.MAX_VALUE;
        int bestTime = 0;

        for (int i = 0; i <= n; i++) {
            int penalty = prefixSum[i] + (n - i - (prefixSum[n] - prefixSum[i]));
            if (penalty < minPenalty) {
                minPenalty = penalty;
                bestTime = i;
            }
        }

        return bestTime;
    }
}