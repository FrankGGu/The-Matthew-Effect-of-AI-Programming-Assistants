import java.util.Stack;

class Solution {
    public int validSubarraySize(int[] nums, int threshold) {
        int n = nums.length;
        Stack<Integer> stack = new Stack<>();

        // Iterate through the array, appending a sentinel value (0) to ensure all elements
        // in the stack are eventually processed. A value of 0 works because nums[i] >= 1
        // and threshold / k will always be positive, so nums[i] > threshold / k would never be true for nums[i] = 0.
        for (int i = 0; i <= n; i++) {
            int currentVal = (i == n) ? 0 : nums[i]; 

            // While the stack is not empty and the current element is smaller than the element
            // at the top of the stack, pop elements from the stack.
            // These popped elements are the minimums of some potential subarrays.
            while (!stack.isEmpty() && nums[stack.peek()] > currentVal) {
                int j = stack.pop();
                long minVal = nums[j];

                // The left boundary of the subarray where nums[j] is the minimum is
                // the index of the element just before the current top of the stack.
                // If the stack is empty, it means nums[j] is the minimum up to index -1.
                int leftBound = stack.isEmpty() ? -1 : stack.peek();

                // The right boundary is the current index 'i' (exclusive),
                // as currentVal is the first element to the right that is smaller than nums[j].
                // The length of the subarray is (i - 1) - (leftBound + 1) + 1 = i - 1 - leftBound.
                long length = i - leftBound - 1;

                // Check the condition: min(nums[l...r]) * k > threshold
                if (minVal * length > threshold) {
                    return (int)length;
                }
            }
            // Push the current index onto the stack.
            stack.push(i);
        }

        // If no such subarray is found after checking all possibilities, return -1.
        return -1;
    }
}