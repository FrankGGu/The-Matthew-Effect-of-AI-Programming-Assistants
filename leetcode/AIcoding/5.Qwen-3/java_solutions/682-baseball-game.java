public class Solution {

import java.util.*;

public class Solution {
    public int calPoints(String[] operations) {
        Stack<Integer> stack = new Stack<>();
        for (String op : operations) {
            if (op.equals("+")) {
                int top = stack.pop();
                int newTop = top + stack.peek();
                stack.push(top);
                stack.push(newTop);
            } else if (op.equals("C")) {
                stack.pop();
            } else if (op.equals("D")) {
                stack.push(2 * stack.peek());
            } else {
                stack.push(Integer.parseInt(op));
            }
        }
        int sum = 0;
        while (!stack.empty()) {
            sum += stack.pop();
        }
        return sum;
    }
}
}