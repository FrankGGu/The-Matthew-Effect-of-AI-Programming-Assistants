class Solution {
    public long maximumBeauty(int[] flowers, int newFlowers, int target) {
        int n = flowers.length;
        long[] prefix = new long[n + 1];
        for (int i = 0; i < n; i++) {
            prefix[i + 1] = prefix[i] + flowers[i];
        }
        long maxBeauty = 0;

        for (int i = 0; i < n; i++) {
            int left = Math.max(flowers[i], target);
            long totalFlowers = (long) left * (i + 1);
            long neededFlowers = totalFlowers - prefix[i + 1];
            if (neededFlowers <= newFlowers) {
                maxBeauty = Math.max(maxBeauty, (long) (i + 1) * (long) target);
            }
        }

        for (int i = n - 1; i >= 0; i--) {
            int left = Math.max(flowers[i], target);
            long totalFlowers = (long) left * (n - i);
            long neededFlowers = totalFlowers - (prefix[n] - prefix[i]);
            if (neededFlowers <= newFlowers) {
                maxBeauty = Math.max(maxBeauty, (long) (n - i) * (long) target);
            }
        }

        return maxBeauty;
    }
}