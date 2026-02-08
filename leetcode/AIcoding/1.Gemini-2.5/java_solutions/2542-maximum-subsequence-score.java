import java.util.Arrays;
import java.util.PriorityQueue;

class Solution {
    public long maxScore(int[] nums1, int[] nums2, int k) {
        int n = nums1.length;
        int[][] pairs = new int[n][2];
        for (int i = 0; i < n; i++) {
            pairs[i][0] = nums1[i];
            pairs[i][1] = nums2[i];
        }

        Arrays.sort(pairs, (a, b) -> b[1] - a[1]);

        PriorityQueue<Integer> minHeap = new PriorityQueue<>();
        long currentSum = 0;
        long maxScore = 0;

        for (int[] pair : pairs) {
            int num1Val = pair[0];
            int num2Val = pair[1];

            minHeap.add(num1Val);
            currentSum += num1Val;

            if (minHeap.size() > k) {
                currentSum -= minHeap.poll();
            }

            if (minHeap.size() == k) {
                maxScore = Math.max(maxScore, currentSum * num2Val);
            }
        }

        return maxScore;
    }
}