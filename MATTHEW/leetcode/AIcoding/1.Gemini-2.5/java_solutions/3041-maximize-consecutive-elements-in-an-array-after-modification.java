import java.util.Arrays;
import java.util.Deque;
import java.util.LinkedList;

class Solution {
    public int maximizeConsecutive(int[] nums, int k) {
        int n = nums.length;
        if (n == 0) {
            return 0;
        }

        Arrays.sort(nums);

        // Deques to maintain the sliding window minimum and maximum of (nums[idx] - idx)
        // min_dq stores indices in increasing order of (nums[idx] - idx) values
        Deque<Integer> min_dq = new LinkedList<>(); 
        // max_dq stores indices in decreasing order of (nums[idx] - idx) values
        Deque<Integer> max_dq = new LinkedList<>(); 

        int left = 0;
        int max_len = 0;

        for (int right = 0; right < n; right++) {
            // Calculate current_val_p = nums[right] - right
            // This is the quantity whose range (max - min) we need to keep <= k
            int current_val_p = nums[right] - right;

            // Update min_dq: remove elements from the back that are greater than or equal to current_val_p
            while (!min_dq.isEmpty() && (nums[min_dq.peekLast()] - min_dq.peekLast()) >= current_val_p) {
                min_dq.removeLast();
            }
            min_dq.addLast(right);

            // Update max_dq: remove elements from the back that are less than or equal to current_val_p
            while (!max_dq.isEmpty() && (nums[max_dq.peekLast()] - max_dq.peekLast()) <= current_val_p) {
                max_dq.removeLast();
            }
            max_dq.addLast(right);

            // Check if the current window [left, right] is valid
            // A window is valid if max(nums[p]-p) - min(nums[p]-p) <= k
            while ((nums[max_dq.peekFirst()] - max_dq.peekFirst()) > (nums[min_dq.peekFirst()] - min_dq.peekFirst()) + k) {
                // The window is invalid, shrink from the left
                // If the leftmost element of the window is the front of a deque, remove it
                if (min_dq.peekFirst() == left) {
                    min_dq.removeFirst();
                }
                if (max_dq.peekFirst() == left) {
                    max_dq.removeFirst();
                }
                left++; // Move the left pointer
            }

            // The current window [left, right] is valid, update max_len
            max_len = Math.max(max_len, right - left + 1);
        }

        return max_len;
    }
}