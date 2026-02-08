import java.util.PriorityQueue;

class Solution {
    public long minimumDifference(int[] nums) {
        int n = nums.length / 3;
        long[] leftSum = new long[3 * n + 1];
        PriorityQueue<Integer> leftHeap = new PriorityQueue<>((a, b) -> b - a);
        long currentLeftSum = 0;
        for (int i = 0; i < n; i++) {
            currentLeftSum += nums[i];
            leftHeap.offer(nums[i]);
        }
        leftSum[n] = currentLeftSum;
        for (int i = n; i < 2 * n; i++) {
            currentLeftSum += nums[i];
            leftHeap.offer(nums[i]);
            currentLeftSum -= leftHeap.poll();
            leftSum[i + 1] = currentLeftSum;
        }

        long[] rightSum = new long[3 * n + 1];
        PriorityQueue<Integer> rightHeap = new PriorityQueue<>();
        long currentRightSum = 0;
        for (int i = 3 * n - 1; i >= 2 * n; i--) {
            currentRightSum += nums[i];
            rightHeap.offer(nums[i]);
        }
        rightSum[2 * n] = currentRightSum;
        for (int i = 2 * n - 1; i >= n; i--) {
            currentRightSum += nums[i];
            rightHeap.offer(nums[i]);
            currentRightSum -= rightHeap.poll();
            rightSum[i] = currentRightSum;
        }

        long minDiff = Long.MAX_VALUE;
        for (int i = n; i <= 2 * n; i++) {
            minDiff = Math.min(minDiff, leftSum[i] - rightSum[i]);
        }

        return minDiff;
    }
}