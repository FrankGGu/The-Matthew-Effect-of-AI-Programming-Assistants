public class Solution {

import java.util.*;

public class Solution {
    public boolean validateBookOrder(int[] booking, int[] output) {
        int n = booking.length;
        Stack<Integer> stack = new Stack<>();
        int j = 0;
        for (int i = 0; i < n; i++) {
            stack.push(booking[i]);
            while (!stack.isEmpty() && stack.peek() == output[j]) {
                stack.pop();
                j++;
            }
        }
        return j == n;
    }
}
}