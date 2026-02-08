import java.util.Deque;
import java.util.LinkedList;

class Solution {
    public int longestSubarray(int[] nums, int limit) {
        Deque<Integer> minDeque = new LinkedList<>();
        Deque<Integer> maxDeque = new LinkedList<>();
        int left = 0;
        int maxLength = 0;

        for (int right = 0; right < nums.length; right++) {
            while (!maxDeque.isEmpty() && maxDeque.peekLast() < nums[right]) {
                maxDeque.removeLast();
            }
            maxDeque.addLast(nums[right]);

            while (!minDeque.isEmpty() && minDeque.peekLast() > nums[right]) {
                minDeque.removeLast();
            }
            minDeque.addLast(nums[right]);

            while (maxDeque.peekFirst() - minDeque.peekFirst() > limit) {
                if (maxDeque.peekFirst() == nums[left]) {
                    maxDeque.removeFirst();
                }
                if (minDeque.peekFirst() == nums[left]) {
                    minDeque.removeFirst();
                }
                left++;
            }

            maxLength = Math.max(maxLength, right - left + 1);
        }

        return maxLength;
    }
}