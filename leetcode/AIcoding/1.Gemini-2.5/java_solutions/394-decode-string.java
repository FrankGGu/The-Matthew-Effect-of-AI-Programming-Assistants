import java.util.Stack;

class Solution {
    public String decodeString(String s) {
        Stack<Integer> numStack = new Stack<>();
        Stack<String> strStack = new Stack<>();
        StringBuilder currentString = new StringBuilder();
        int currentNum = 0;

        for (char c : s.toCharArray()) {
            if (Character.isDigit(c)) {
                currentNum = currentNum * 10 + (c - '0');
            } else if (c == '[') {
                numStack.push(currentNum);
                strStack.push(currentString.toString());
                currentNum = 0;
                currentString = new StringBuilder();
            } else if (c == ']') {
                int num = numStack.pop();
                StringBuilder prevString = new StringBuilder(strStack.pop());
                for (int i = 0; i < num; i++) {
                    prevString.append(currentString);
                }
                currentString = prevString;
            } else {
                currentString.append(c);
            }
        }

        return currentString.toString();
    }
}