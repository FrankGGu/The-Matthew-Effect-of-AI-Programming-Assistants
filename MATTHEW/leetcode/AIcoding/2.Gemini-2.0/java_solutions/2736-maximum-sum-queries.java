import java.util.Arrays;
import java.util.PriorityQueue;

class Solution {
    public long[] maximumSumQueries(int[] nums1, int[] nums2, int[][] queries) {
        int n = nums1.length;
        int q = queries.length;
        Integer[] indices = new Integer[q];
        for (int i = 0; i < q; i++) {
            indices[i] = i;
        }
        Arrays.sort(indices, (i, j) -> Integer.compare(queries[j][0], queries[i][0]));

        int[][] pairs = new int[n][2];
        for (int i = 0; i < n; i++) {
            pairs[i][0] = nums1[i];
            pairs[i][1] = nums2[i];
        }
        Arrays.sort(pairs, (a, b) -> Integer.compare(b[0], a[0]));

        long[] result = new long[q];
        PriorityQueue<int[]> pq = new PriorityQueue<>((a, b) -> Integer.compare(b[1], a[1]));

        int pairIndex = 0;
        for (int queryIndex : indices) {
            int x = queries[queryIndex][0];
            int y = queries[queryIndex][1];

            while (pairIndex < n && pairs[pairIndex][0] >= x) {
                pq.offer(pairs[pairIndex]);
                pairIndex++;
            }

            while (!pq.isEmpty() && pq.peek()[1] < y) {
                pq.poll();
            }

            if (pq.isEmpty()) {
                result[queryIndex] = -1;
            } else {
                int[] top = pq.peek();
                result[queryIndex] = (long) top[0] + top[1];
            }
        }

        return result;
    }
}