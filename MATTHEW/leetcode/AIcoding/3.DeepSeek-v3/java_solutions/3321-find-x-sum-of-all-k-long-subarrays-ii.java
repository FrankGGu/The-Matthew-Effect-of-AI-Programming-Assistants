class Solution {
    public long getXSum(int[] nums, int k) {
        int n = nums.length;
        long sum = 0;
        Deque<Integer> deque = new ArrayDeque<>();

        for (int i = 0; i < n; i++) {
            while (!deque.isEmpty() && deque.peekFirst() < i - k + 1) {
                deque.pollFirst();
            }
            while (!deque.isEmpty() && nums[deque.peekLast()] < nums[i]) {
                deque.pollLast();
            }
            deque.offerLast(i);
            if (i >= k - 1) {
                sum += nums[deque.peekFirst()];
            }
        }
        return sum;
    }
}