import java.util.*;

class Solution {
    public int[] maxMinSum(int[] nums, int k) {
        int n = nums.length;
        int[] maxSum = getMaxSum(nums, k);
        int[] minSum = getMinSum(nums, k);
        return new int[]{maxSum[0], minSum[0]};
    }

    private int[] getMaxSum(int[] nums, int k) {
        int n = nums.length;
        int[] res = new int[n - k + 1];
        Deque<Integer> dq = new ArrayDeque<>();
        int sum = 0;

        for (int i = 0; i < n; i++) {
            while (!dq.isEmpty() && nums[i] >= nums[dq.peekLast()]) {
                dq.pollLast();
            }
            dq.offerLast(i);
            if (i >= k - 1) {
                res[i - k + 1] = nums[dq.peekFirst()];
                if (dq.peekFirst() == i - k + 1) {
                    dq.pollFirst();
                }
            }
        }

        int max = Integer.MIN_VALUE;
        for (int num : res) {
            if (num > max) {
                max = num;
            }
        }
        return new int[]{max};
    }

    private int[] getMinSum(int[] nums, int k) {
        int n = nums.length;
        int[] res = new int[n - k + 1];
        Deque<Integer> dq = new ArrayDeque<>();
        int sum = 0;

        for (int i = 0; i < n; i++) {
            while (!dq.isEmpty() && nums[i] <= nums[dq.peekLast()]) {
                dq.pollLast();
            }
            dq.offerLast(i);
            if (i >= k - 1) {
                res[i - k + 1] = nums[dq.peekFirst()];
                if (dq.peekFirst() == i - k + 1) {
                    dq.pollFirst();
                }
            }
        }

        int min = Integer.MAX_VALUE;
        for (int num : res) {
            if (num < min) {
                min = num;
            }
        }
        return new int[]{min};
    }
}