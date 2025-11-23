import java.util.Arrays;
import java.util.Stack;
import java.util.ArrayList;
import java.util.List;

class Solution {
    public int[] nextGreaterElement(int[] nums) {
        int n = nums.length;
        int[] ans = new int[n];
        Arrays.fill(ans, -1);

        Stack<Integer> s1 = new Stack<>(); // Stores indices for which we are looking for their first NGE
        Stack<Integer> s2 = new Stack<>(); // Stores indices for which we have found their first NGE, now looking for second NGE

        for (int i = 0; i < n; i++) {
            // Step 1: Process s2 (find second NGEs)
            // For elements in s2, if nums[i] is greater, it's their second NGE.
            while (!s2.isEmpty() && nums[s2.peek()] < nums[i]) {
                ans[s2.pop()] = nums[i];
            }

            // Step 2: Process s1 (find first NGEs and move them to s2)
            // Create a temporary list to hold indices that just found their first NGE.
            // These indices will then be moved to s2.
            List<Integer> tempForS2 = new ArrayList<>();
            while (!s1.isEmpty() && nums[s1.peek()] < nums[i]) {
                tempForS2.add(s1.pop());
            }

            // Push current index 'i' to s1, as it's a candidate for other elements' NGE.
            s1.push(i);

            // Move elements from tempForS2 to s2.
            // Elements in tempForS2 were popped from s1 in increasing order of their values.
            // To maintain s2's decreasing monotonic property (nums[s2.peek()] is decreasing),
            // we must push them in reverse order (largest value first).
            for (int j = tempForS2.size() - 1; j >= 0; j--) {
                s2.push(tempForS2.get(j));
            }
        }

        return ans;
    }
}