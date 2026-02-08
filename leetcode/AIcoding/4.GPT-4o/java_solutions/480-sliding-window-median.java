import java.util.*;

class Solution {
    public double[] medianSlidingWindow(int[] nums, int k) {
        if (nums == null || nums.length == 0 || k == 0) return new double[0];
        double[] result = new double[nums.length - k + 1];
        PriorityQueue<Integer> left = new PriorityQueue<>(Collections.reverseOrder());
        PriorityQueue<Integer> right = new PriorityQueue<>();
        for (int i = 0; i < nums.length; i++) {
            if (left.isEmpty() || nums[i] <= left.peek()) {
                left.offer(nums[i]);
            } else {
                right.offer(nums[i]);
            }
            if (left.size() > k / 2) {
                right.offer(left.poll());
            }
            if (right.size() > (k - 1) / 2) {
                left.offer(right.poll());
            }
            if (i >= k - 1) {
                result[i - k + 1] = k % 2 == 0 ? (left.peek() + right.peek()) / 2.0 : left.peek();
                int out = nums[i - k + 1];
                if (out <= left.peek()) {
                    left.remove(out);
                } else {
                    right.remove(out);
                }
                if (left.size() < (k + 1) / 2) {
                    left.offer(right.poll());
                }
                if (right.size() < k / 2) {
                    right.offer(left.poll());
                }
            }
        }
        return result;
    }
}