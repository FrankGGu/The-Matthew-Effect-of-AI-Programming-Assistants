import java.util.ArrayDeque;
import java.util.Deque;

class Solution {
    public int[] mostCompetitive(int[] nums, int k) {
        Deque<Integer> stack = new ArrayDeque<>();
        int n = nums.length;

        for (int i = 0; i < n; i++) {
            // While the stack is not empty, the current number is smaller than the top of the stack,
            // AND we can still form a subsequence of length k even if we pop the current top.
            // The condition for being able to pop is:
            // (number of elements remaining in stack after pop) + (number of elements remaining in nums from current index i to end) >= k
            // (stack.size() - 1) + (n - i) >= k
            while (!stack.isEmpty() && stack.peekLast() > nums[i] && (stack.size() - 1) + (n - i) >= k) {
                stack.removeLast();
            }

            // If the stack size is less than k, push the current number onto the stack.
            // This ensures we build a subsequence of length k.
            if (stack.size() < k) {
                stack.addLast(nums[i]);
            }
        }

        // Transfer elements from the stack to the result array.
        // Since ArrayDeque adds to the last and removes from the first,
        // the elements are in the correct order for the result array.
        int[] result = new int[k];
        for (int i = 0; i < k; i++) {
            result[i] = stack.removeFirst();
        }

        return result;
    }
}