public class Solution {

import java.util.*;

public class Solution {
    public String minRemoveToMakeValid(String s) {
        Set<Integer> removeIndices = new HashSet<>();
        Stack<Integer> stack = new Stack<>();

        for (int i = 0; i < s.length(); i++) {
            char c = s.charAt(i);
            if (c == '(') {
                stack.push(i);
            } else if (c == ')') {
                if (!stack.isEmpty()) {
                    stack.pop();
                } else {
                    removeIndices.add(i);
                }
            }
        }

        removeIndices.addAll(stack);

        StringBuilder result = new StringBuilder();
        for (int i = 0; i < s.length(); i++) {
            if (!removeIndices.contains(i)) {
                result.append(s.charAt(i));
            }
        }

        return result.toString();
    }
}
}