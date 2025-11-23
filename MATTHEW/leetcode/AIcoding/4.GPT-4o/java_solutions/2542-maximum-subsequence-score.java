import java.util.Arrays;
import java.util.Comparator;
import java.util.PriorityQueue;

class Solution {
    public long maxScore(int[] nums1, int[] nums2, int k) {
        int n = nums1.length;
        long[][] pairs = new long[n][2];
        for (int i = 0; i < n; i++) {
            pairs[i][0] = nums1[i];
            pairs[i][1] = nums2[i];
        }
        Arrays.sort(pairs, Comparator.comparingDouble(a -> -a[1]));

        long sum = 0;
        long maxScore = 0;
        PriorityQueue<Long> minHeap = new PriorityQueue<>();

        for (int i = 0; i < k; i++) {
            sum += pairs[i][0];
            minHeap.offer(pairs[i][0]);
        }
        maxScore = sum * pairs[k - 1][1];

        for (int i = k; i < n; i++) {
            sum += pairs[i][0];
            minHeap.offer(pairs[i][0]);
            sum -= minHeap.poll();
            maxScore = Math.max(maxScore, sum * pairs[i][1]);
        }

        return maxScore;
    }
}