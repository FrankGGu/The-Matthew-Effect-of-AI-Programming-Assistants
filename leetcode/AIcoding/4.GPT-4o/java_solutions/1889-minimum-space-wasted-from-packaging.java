import java.util.Arrays;

class Solution {
    public int minWastedSpace(int[] packages, int[] boxes) {
        Arrays.sort(packages);
        Arrays.sort(boxes);

        long total = 0;
        for (int p : packages) total += p;

        long minWasted = Long.MAX_VALUE;
        int n = packages.length;

        for (int b : boxes) {
            if (b < packages[n - 1]) continue;

            long wasted = 0;
            int j = 0;
            for (int i = 0; i < n; i++) {
                while (j < n && packages[j] <= b) j++;
                wasted += b - packages[i];
                if (i == j - 1) break;
            }
            minWasted = Math.min(minWasted, wasted);
        }

        return minWasted == Long.MAX_VALUE ? 0 : (int) (minWasted);
    }
}