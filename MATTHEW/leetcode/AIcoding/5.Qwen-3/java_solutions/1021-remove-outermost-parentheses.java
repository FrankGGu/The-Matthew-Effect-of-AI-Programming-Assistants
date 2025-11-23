public class Solution {

class Solution {
    public String removeOuterParentheses(String s) {
        StringBuilder result = new StringBuilder();
        int balance = 0;
        for (char c : s.toCharArray()) {
            if (c == '(') {
                balance++;
            }
            if (balance > 1) {
                result.append(c);
            }
            if (c == ')') {
                balance--;
            }
        }
        return result.toString();
    }
}
}