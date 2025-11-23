import java.util.Deque;
import java.util.LinkedList;

class Solution {
    public int longestSubarray(int[] nums, int limit) {
        Deque<Integer> maxQueue = new LinkedList<>();
        Deque<Integer> minQueue = new LinkedList<>();
        int left = 0;
        int right = 0;
        int maxLength = 0;

        while (right < nums.length) {
            while (!maxQueue.isEmpty() && nums[right] > nums[maxQueue.peekLast()]) {
                maxQueue.pollLast();
            }
            maxQueue.offerLast(right);

            while (!minQueue.isEmpty() && nums[right] < nums[minQueue.peekLast()]) {
                minQueue.pollLast();
            }
            minQueue.offerLast(right);

            while (Math.abs(nums[maxQueue.peekFirst()] - nums[minQueue.peekFirst()]) > limit) {
                if (maxQueue.peekFirst() == left) {
                    maxQueue.pollFirst();
                }
                if (minQueue.peekFirst() == left) {
                    minQueue.pollFirst();
                }
                left++;
            }

            maxLength = Math.max(maxLength, right - left + 1);
            right++;
        }

        return maxLength;
    }
}