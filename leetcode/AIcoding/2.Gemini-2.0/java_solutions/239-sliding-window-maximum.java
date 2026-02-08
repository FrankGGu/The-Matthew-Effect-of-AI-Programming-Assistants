import java.util.ArrayDeque;
import java.util.Deque;

class Solution {
    public int[] maxSlidingWindow(int[] nums, int k) {
        int n = nums.length;
        if (n * k == 0) return new int[0];
        if (k == 1) return nums;

        int[] output = new int[n - k + 1];
        Deque<Integer> deque = new ArrayDeque<>();

        for (int i = 0; i < n; i++) {
            while (!deque.isEmpty() && nums[deque.peekLast()] < nums[i]) {
                deque.removeLast();
            }
            deque.addLast(i);

            if (i - deque.peekFirst() >= k) {
                deque.removeFirst();
            }

            if (i >= k - 1) {
                output[i - k + 1] = nums[deque.peekFirst()];
            }
        }
        return output;
    }
}