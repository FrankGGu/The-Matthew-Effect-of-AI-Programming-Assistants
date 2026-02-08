public class Solution {

import java.util.*;

public class Solution {
    public List<Integer> mostCompetitiveSubsequence(int[] nums, int k) {
        List<Integer> result = new ArrayList<>();
        Stack<Integer> stack = new Stack<>();

        for (int i = 0; i < nums.length; i++) {
            while (!stack.isEmpty() && nums[i] < stack.peek() && stack.size() + nums.length - i > k) {
                stack.pop();
            }
            if (stack.size() < k) {
                stack.push(nums[i]);
            }
        }

        while (!stack.isEmpty()) {
            result.add(0, stack.pop());
        }

        return result;
    }
}
}