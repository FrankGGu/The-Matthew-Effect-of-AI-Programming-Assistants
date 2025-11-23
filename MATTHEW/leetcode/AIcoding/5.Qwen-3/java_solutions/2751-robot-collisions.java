public class Solution {

import java.util.*;

public class Solution {
    public int countCollisions(String s) {
        Stack<Character> stack = new Stack<>();
        for (char c : s.toCharArray()) {
            if (stack.isEmpty()) {
                stack.push(c);
            } else {
                char top = stack.peek();
                if (top == 'R' && c == 'L') {
                    stack.pop();
                    stack.push('S');
                    while (!stack.isEmpty() && stack.peek() == 'R') {
                        stack.pop();
                        stack.push('S');
                    }
                } else if (top == 'S' && c == 'L') {
                    stack.push('S');
                } else {
                    stack.push(c);
                }
            }
        }
        int count = 0;
        for (char c : stack) {
            if (c == 'S') {
                count++;
            }
        }
        return count;
    }
}
}