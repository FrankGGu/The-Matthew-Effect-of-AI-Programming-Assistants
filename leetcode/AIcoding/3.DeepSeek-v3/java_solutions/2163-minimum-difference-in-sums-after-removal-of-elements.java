import java.util.PriorityQueue;

class Solution {
    public long minimumDifference(int[] nums) {
        int n = nums.length / 3;
        PriorityQueue<Integer> left = new PriorityQueue<>((a, b) -> b - a);
        PriorityQueue<Integer> right = new PriorityQueue<>();
        long[] leftSum = new long[n + 1];
        long[] rightSum = new long[n + 1];
        long sum = 0;

        for (int i = 0; i < 2 * n; i++) {
            left.add(nums[i]);
            sum += nums[i];
            if (left.size() > n) {
                sum -= left.poll();
            }
            if (i >= n - 1) {
                leftSum[i - n + 1] = sum;
            }
        }

        sum = 0;
        for (int i = 3 * n - 1; i >= n; i--) {
            right.add(nums[i]);
            sum += nums[i];
            if (right.size() > n) {
                sum -= right.poll();
            }
            if (i <= 2 * n) {
                rightSum[i - n] = sum;
            }
        }

        long res = Long.MAX_VALUE;
        for (int i = 0; i <= n; i++) {
            res = Math.min(res, leftSum[i] - rightSum[i]);
        }
        return res;
    }
}