import java.util.Arrays;

class Solution {
    public int maximumScore(int[] nums, int k) {
        int n = nums.length;
        int[] left = new int[n];
        int[] right = new int[n];
        Arrays.fill(left, -1);
        Arrays.fill(right, n);

        java.util.Stack<Integer> stack = new java.util.Stack<>();
        for (int i = 0; i < n; i++) {
            while (!stack.isEmpty() && nums[stack.peek()] > nums[i]) {
                right[stack.pop()] = i;
            }
            stack.push(i);
        }

        stack.clear();
        for (int i = n - 1; i >= 0; i--) {
            while (!stack.isEmpty() && nums[stack.peek()] >= nums[i]) {
                left[stack.pop()] = i;
            }
            stack.push(i);
        }

        Integer[] indices = new Integer[n];
        for (int i = 0; i < n; i++) {
            indices[i] = i;
        }
        Arrays.sort(indices, (a, b) -> nums[b] - nums[a]);

        long ans = 0;
        int mod = 1000000007;
        for (int i = 0; i < n && k > 0; i++) {
            int index = indices[i];
            long count = (long) (index - left[index]) * (right[index] - index);
            if (count <= k) {
                ans = (ans + (long) nums[index] * count) % mod;
                k -= count;
            } else {
                ans = (ans + (long) nums[index] * k) % mod;
                k = 0;
            }
        }

        return (int) ans;
    }
}