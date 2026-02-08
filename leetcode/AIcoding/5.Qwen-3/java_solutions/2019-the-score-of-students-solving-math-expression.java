public class Solution {

import java.util.*;

public class Solution {
    public int scoreOfStudents(String s) {
        Set<Integer> correct = new HashSet<>();
        correct.add(evaluate(s));
        Set<Integer> students = new HashSet<>();
        students.add(0);
        for (int i = 0; i < s.length(); i++) {
            if (s.charAt(i) == '+') {
                String left = s.substring(0, i);
                String right = s.substring(i + 1);
                int valLeft = evaluate(left);
                int valRight = evaluate(right);
                students.add(valLeft + valRight);
            }
        }
        int res = 0;
        for (int num : students) {
            if (num <= 100 && correct.contains(num)) {
                res++;
            }
        }
        return res;
    }

    private int evaluate(String s) {
        Stack<Integer> stack = new Stack<>();
        int num = 0;
        char sign = '+';
        for (int i = 0; i < s.length(); i++) {
            char c = s.charAt(i);
            if (Character.isDigit(c)) {
                num = num * 10 + (c - '0');
            }
            if (!Character.isDigit(c) && c != ' ' || i == s.length() - 1) {
                if (sign == '+') {
                    stack.push(num);
                } else if (sign == '-') {
                    stack.push(-num);
                } else if (sign == '*') {
                    stack.push(stack.pop() * num);
                } else if (sign == '/') {
                    stack.push(stack.pop() / num);
                }
                sign = c;
                num = 0;
            }
        }
        int sum = 0;
        while (!stack.isEmpty()) {
            sum += stack.pop();
        }
        return sum;
    }
}
}