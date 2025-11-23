public class Solution {
    public int minimumPenalty(String customers) {
        int n = customers.length();
        int[] prefix = new int[n + 1];

        for (int i = 0; i < n; i++) {
            prefix[i + 1] = prefix[i] + (customers.charAt(i) == 'Y' ? 1 : 0);
        }

        int minPenalty = Integer.MAX_VALUE;
        for (int i = 0; i <= n; i++) {
            int penalty = prefix[i] + (n - i) - (prefix[n] - prefix[i]);
            minPenalty = Math.min(minPenalty, penalty);
        }

        return minPenalty;
    }
}