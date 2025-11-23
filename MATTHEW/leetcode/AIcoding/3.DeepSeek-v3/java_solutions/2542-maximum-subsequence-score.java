import java.util.Arrays;
import java.util.PriorityQueue;

class Solution {
    public long maxScore(int[] nums1, int[] nums2, int k) {
        int n = nums1.length;
        int[][] pairs = new int[n][2];
        for (int i = 0; i < n; i++) {
            pairs[i] = new int[]{nums2[i], nums1[i]};
        }
        Arrays.sort(pairs, (a, b) -> b[0] - a[0]);
        PriorityQueue<Integer> minHeap = new PriorityQueue<>();
        long sum = 0;
        long res = 0;
        for (int[] pair : pairs) {
            sum += pair[1];
            minHeap.offer(pair[1]);
            if (minHeap.size() > k) {
                sum -= minHeap.poll();
            }
            if (minHeap.size() == k) {
                res = Math.max(res, sum * pair[0]);
            }
        }
        return res;
    }
}