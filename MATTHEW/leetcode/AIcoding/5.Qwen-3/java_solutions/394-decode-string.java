public class Solution {

import java.util.Stack;

public class Solution {
    public String decodeString(String s) {
        Stack<Integer> numStack = new Stack<>();
        Stack<String> strStack = new Stack<>();
        StringBuilder currentNum = new StringBuilder();
        StringBuilder currentStr = new StringBuilder();

        for (char c : s.toCharArray()) {
            if (Character.isDigit(c)) {
                currentNum.append(c);
            } else if (c == '[') {
                numStack.push(Integer.parseInt(currentNum.toString()));
                strStack.push(currentStr.toString());
                currentNum = new StringBuilder();
                currentStr = new StringBuilder();
            } else if (c == ']') {
                int num = numStack.pop();
                String prevStr = strStack.pop();
                StringBuilder temp = new StringBuilder();
                for (int i = 0; i < num; i++) {
                    temp.append(currentStr);
                }
                currentStr = new StringBuilder(prevStr + temp);
            } else {
                currentStr.append(c);
            }
        }

        return currentStr.toString();
    }
}
}