public class Solution {

import java.util.*;

public class Solution {
    public int[] getBeautifulTowerII(int[] nums) {
        int n = nums.length;
        int[] left = new int[n];
        int[] right = new int[n];
        Stack<Integer> stack = new Stack<>();

        for (int i = 0; i < n; i++) {
            while (!stack.isEmpty() && nums[stack.peek()] < nums[i]) {
                stack.pop();
            }
            if (!stack.isEmpty()) {
                left[i] = nums[stack.peek()];
            } else {
                left[i] = 0;
            }
            stack.push(i);
        }

        stack.clear();

        for (int i = n - 1; i >= 0; i--) {
            while (!stack.isEmpty() && nums[stack.peek()] < nums[i]) {
                stack.pop();
            }
            if (!stack.isEmpty()) {
                right[i] = nums[stack.peek()];
            } else {
                right[i] = 0;
            }
            stack.push(i);
        }

        int[] result = new int[n];
        for (int i = 0; i < n; i++) {
            result[i] = left[i] + right[i];
        }

        return result;
    }
}
}