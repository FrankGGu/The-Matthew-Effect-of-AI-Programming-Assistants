import java.util.ArrayDeque;
import java.util.Deque;

class Solution {
    public int totalSteps(int[] nums) {
        int n = nums.length;
        if (n <= 1) {
            return 0;
        }

        // dp[i] stores the number of steps nums[i] survives before being removed by an element to its left.
        // If nums[i] is never removed, dp[i] will effectively be 0.
        int[] dp = new int[n]; 
        int maxSteps = 0;

        // Stack stores indices of elements in a non-increasing order.
        // Elements are (index, value) pairs, but we only store index and use nums[index] to get value.
        Deque<Integer> stack = new ArrayDeque<>(); 

        for (int i = 0; i < n; i++) {
            int currentSurvivalSteps = 0;

            // Pop elements from stack that are less than or equal to nums[i].
            // These elements will be removed by nums[i] (or an element to its left that nums[i] also removes).
            while (!stack.isEmpty() && nums[stack.peek()] <= nums[i]) {
                int prevIdx = stack.pop();

                // If nums[i] is strictly greater than nums[prevIdx], then nums[prevIdx] is removed.
                // nums[i] "inherits" the survival steps of nums[prevIdx] and adds 1 for itself.
                // It means nums[i] survives at least (dp[prevIdx] + 1) steps.
                currentSurvivalSteps = Math.max(currentSurvivalSteps, dp[prevIdx]) + 1;
            }

            // If the stack is empty after popping, it means nums[i] is the largest element encountered so far.
            // It will not be removed by any element to its left. So its survival steps should be 0.
            // The 'currentSurvivalSteps' calculation naturally handles this. If stack becomes empty,
            // currentSurvivalSteps would be 0 if no elements were popped, or it would be the max steps
            // of the elements it removed. But if it's the largest, it won't be removed, so its own dp value is 0.
            // However, the problem asks for the maximum steps for the *array* to become non-decreasing.
            // The 'currentSurvivalSteps' represents the number of steps it takes for nums[i] to be removed *if* it is removed.
            // If nums[i] is the largest element so far (stack is empty), it will never be removed.
            // In this specific case, currentSurvivalSteps should be 0.
            // This is handled by checking if the stack is empty. If it is, then nums[i] is the largest so far,
            // and it will never be removed by an element to its left. So its effective 'survival steps' is 0.
            if (stack.isEmpty()) {
                dp[i] = 0;
            } else {
                // If stack is not empty, it means nums[i] is smaller than nums[stack.peek()].
                // So nums[i] will eventually be removed by nums[stack.peek()] in 'currentSurvivalSteps' steps.
                dp[i] = currentSurvivalSteps;
            }

            maxSteps = Math.max(maxSteps, dp[i]);
            stack.push(i);
        }

        return maxSteps;
    }
}