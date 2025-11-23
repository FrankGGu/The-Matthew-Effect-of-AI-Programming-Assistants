import java.util.Stack;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

class Solution {
    public boolean isValid(String code) {
        Stack<String> stack = new Stack<>();
        int i = 0;
        while (i < code.length()) {
            if (code.startsWith("<![CDATA[", i)) {
                int j = i + 9;
                while (j < code.length() && !code.startsWith("]]>", j)) {
                    j++;
                }
                if (j == code.length()) {
                    return false;
                }
                i = j + 3;
            } else if (code.startsWith("<", i)) {
                if (code.startsWith("</", i)) {
                    int j = i + 2;
                    while (j < code.length() && code.charAt(j) != '>') {
                        j++;
                    }
                    if (j == code.length()) {
                        return false;
                    }
                    String tag = code.substring(i + 2, j);
                    if (stack.isEmpty() || !stack.peek().equals(tag)) {
                        return false;
                    }
                    stack.pop();
                    i = j + 1;
                    if (stack.isEmpty() && i < code.length()) {
                        return false;
                    }
                } else {
                    int j = i + 1;
                    while (j < code.length() && code.charAt(j) != '>') {
                        j++;
                    }
                    if (j == code.length()) {
                        return false;
                    }
                    String tag = code.substring(i + 1, j);
                    if (tag.length() < 1 || tag.length() > 9) {
                        return false;
                    }
                    Pattern pattern = Pattern.compile("[A-Z]+");
                    Matcher matcher = pattern.matcher(tag);
                    if (!matcher.matches()) {
                        return false;
                    }
                    stack.push(tag);
                    i = j + 1;
                }
            } else {
                if (stack.isEmpty()) {
                    return false;
                }
                i++;
            }
        }
        return stack.isEmpty();
    }
}