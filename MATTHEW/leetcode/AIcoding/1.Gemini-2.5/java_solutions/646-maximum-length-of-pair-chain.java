import java.util.Arrays;
import java.util.Comparator;

class Solution {
    public int findLongestChain(int[][] pairs) {
        if (pairs == null || pairs.length == 0) {
            return 0;
        }

        Arrays.sort(pairs, new Comparator<int[]>() {
            @Override
            public int compare(int[] a, int[] b) {
                return a[1] - b[1];
            }
        });

        int count = 0;
        int currentEnd = Integer.MIN_VALUE;

        for (int[] pair : pairs) {
            if (pair[0] > currentEnd) {
                count++;
                currentEnd = pair[1];
            }
        }

        return count;
    }
}