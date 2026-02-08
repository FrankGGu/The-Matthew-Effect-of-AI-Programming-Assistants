import java.util.Stack;

public class Solution {
    public boolean isValid(String code) {
        if (code == null || code.length() < 7) return false;
        Stack<String> stack = new Stack<>();
        int i = 0;
        while (i < code.length()) {
            if (code.startsWith("<![CDATA[", i)) {
                int j = i + 9;
                int end = code.indexOf("]]>", j);
                if (end == -1) return false;
                i = end + 3;
                continue;
            }
            if (code.startsWith("<", i)) {
                int j = code.indexOf(">", i);
                if (j == -1) return false;
                String tag = code.substring(i + 1, j);
                if (tag.isEmpty() || !isValidTag(tag)) return false;
                if (!tag.startsWith("/")) {
                    stack.push(tag);
                } else {
                    if (stack.isEmpty() || !stack.pop().equals(tag.substring(1))) return false;
                }
                i = j + 1;
            } else {
                i++;
            }
        }
        return stack.isEmpty();
    }

    private boolean isValidTag(String tag) {
        if (tag.length() > 9 || tag.length() == 0 || !Character.isUpperCase(tag.charAt(0))) return false;
        for (char c : tag.toCharArray()) {
            if (!Character.isUpperCase(c) && !Character.isDigit(c)) return false;
        }
        return true;
    }
}