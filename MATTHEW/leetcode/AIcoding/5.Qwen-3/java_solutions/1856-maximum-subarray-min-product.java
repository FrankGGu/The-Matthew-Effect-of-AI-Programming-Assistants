public class Solution {

import java.util.*;

public class Solution {
    public int maxSubarrayMinProduct(int[] nums) {
        int n = nums.length;
        long[] left = new long[n];
        long[] right = new long[n];
        Arrays.fill(left, -1);
        Arrays.fill(right, n);

        Stack<Integer> stack = new Stack<>();

        for (int i = 0; i < n; i++) {
            while (!stack.isEmpty() && nums[stack.peek()] > nums[i]) {
                int idx = stack.pop();
                right[idx] = i;
            }
            if (!stack.isEmpty()) {
                left[i] = stack.peek();
            }
            stack.push(i);
        }

        stack.clear();

        for (int i = n - 1; i >= 0; i--) {
            while (!stack.isEmpty() && nums[stack.peek()] > nums[i]) {
                int idx = stack.pop();
                left[idx] = i;
            }
            if (!stack.isEmpty()) {
                right[i] = stack.peek();
            }
            stack.push(i);
        }

        long max = 0;
        for (int i = 0; i < n; i++) {
            long min = nums[i];
            long l = left[i] + 1;
            long r = right[i] - 1;
            long sum = (r - l + 1) * min;
            max = Math.max(max, sum);
        }

        return (int) max;
    }
}
}