public class Solution {

import java.util.*;

public class Solution {
    public int maximumScore(int[] nums, int k) {
        int n = nums.length;
        int[] left = new int[n];
        int[] right = new int[n];
        Arrays.fill(left, -1);
        Arrays.fill(right, n);

        Deque<Integer> stack = new ArrayDeque<>();
        for (int i = 0; i < n; i++) {
            while (!stack.isEmpty() && nums[stack.peek()] > nums[i]) {
                right[stack.pop()] = i;
            }
            stack.push(i);
        }

        stack.clear();
        for (int i = n - 1; i >= 0; i--) {
            while (!stack.isEmpty() && nums[stack.peek()] > nums[i]) {
                left[stack.pop()] = i;
            }
            stack.push(i);
        }

        int result = 0;
        for (int i = 0; i < n; i++) {
            int width = right[i] - left[i] - 1;
            int score = nums[i] * width;
            if (score > result) {
                result = score;
            }
        }

        return result;
    }
}
}