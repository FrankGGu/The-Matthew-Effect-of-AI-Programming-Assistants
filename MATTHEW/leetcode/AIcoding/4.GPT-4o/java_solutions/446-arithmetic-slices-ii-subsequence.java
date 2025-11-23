class Solution {
    public int numberOfArithmeticSlices(int[] A) {
        int n = A.length;
        if (n < 3) return 0;

        int result = 0;
        HashMap<Integer, Integer>[] dp = new HashMap[n];
        for (int i = 0; i < n; i++) {
            dp[i] = new HashMap<>();
        }

        for (int i = 0; i < n; i++) {
            for (int j = 0; j < i; j++) {
                long diff = (long) A[i] - A[j];
                if (diff > Integer.MAX_VALUE || diff < Integer.MIN_VALUE) continue;

                int d = (int) diff;
                int count = dp[j].getOrDefault(d, 0);
                dp[i].put(d, dp[i].getOrDefault(d, 0) + count + 1);
                result += count;
            }
        }

        return result;
    }
}