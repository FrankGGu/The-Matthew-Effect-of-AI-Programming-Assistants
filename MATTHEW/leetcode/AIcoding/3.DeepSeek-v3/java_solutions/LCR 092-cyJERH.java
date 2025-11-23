class Solution {
    public int minFlipsMonoIncr(String s) {
        int n = s.length();
        int[] prefixOnes = new int[n + 1];
        for (int i = 0; i < n; i++) {
            prefixOnes[i + 1] = prefixOnes[i] + (s.charAt(i) == '1' ? 1 : 0);
        }
        int minFlips = Integer.MAX_VALUE;
        for (int i = 0; i <= n; i++) {
            int flips = prefixOnes[i] + (n - i) - (prefixOnes[n] - prefixOnes[i]);
            minFlips = Math.min(minFlips, flips);
        }
        return minFlips;
    }
}