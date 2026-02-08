class Solution {
    public int maximizeWin(int[] prizePositions, int k) {
        int n = prizePositions.length;
        int[] prefix = new int[n];
        int l = 0;
        for (int r = 0; r < n; r++) {
            while (prizePositions[r] - prizePositions[l] > k) {
                l++;
            }
            prefix[r] = r - l + 1;
        }

        int[] suffixMax = new int[n + 1];
        suffixMax[n] = 0;
        for (int i = n - 1; i >= 0; i--) {
            suffixMax[i] = Math.max(suffixMax[i + 1], prefix[i]);
        }

        int ans = 0;
        l = 0;
        for (int r = 0; r < n; r++) {
            while (prizePositions[r] - prizePositions[l] > k) {
                l++;
            }
            int first = r - l + 1;
            ans = Math.max(ans, first + suffixMax[r + 1]);
        }
        return ans;
    }
}