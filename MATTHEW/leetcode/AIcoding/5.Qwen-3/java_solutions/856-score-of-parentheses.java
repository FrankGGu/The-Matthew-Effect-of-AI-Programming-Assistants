public class Solution {

import java.util.Stack;

public class Solution {
    public int scoreOfParentheses(String S) {
        Stack<Integer> stack = new Stack<>();
        int score = 0;
        for (char c : S.toCharArray()) {
            if (c == '(') {
                stack.push(score);
                score = 0;
            } else {
                score = stack.pop() + Math.max(1, score * 2);
            }
        }
        return score;
    }
}
}