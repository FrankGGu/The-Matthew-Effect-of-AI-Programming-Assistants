class Solution {
    public long continuousSubarrays(int[] nums) {
        long result = 0;
        Deque<Integer> maxDeque = new ArrayDeque<>();
        Deque<Integer> minDeque = new ArrayDeque<>();
        int left = 0;

        for (int right = 0; right < nums.length; right++) {
            while (!maxDeque.isEmpty() && nums[maxDeque.peekLast()] < nums[right]) {
                maxDeque.pollLast();
            }
            maxDeque.offerLast(right);

            while (!minDeque.isEmpty() && nums[minDeque.peekLast()] > nums[right]) {
                minDeque.pollLast();
            }
            minDeque.offerLast(right);

            while (nums[maxDeque.peekFirst()] - nums[minDeque.peekFirst()] > 2) {
                left++;
                while (maxDeque.peekFirst() < left) {
                    maxDeque.pollFirst();
                }
                while (minDeque.peekFirst() < left) {
                    minDeque.pollFirst();
                }
            }

            result += right - left + 1;
        }

        return result;
    }
}