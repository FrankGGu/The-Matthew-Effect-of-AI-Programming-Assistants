public class Solution {
    public NestedInteger deserialize(String s) {
        if (s.charAt(0) != '[') {
            return new NestedInteger(Integer.parseInt(s));
        }
        Stack<NestedInteger> stack = new Stack<>();
        NestedInteger curr = null;
        int start = 0;
        for (int i = 0; i < s.length(); i++) {
            char c = s.charAt(i);
            if (c == '[') {
                if (curr != null) {
                    stack.push(curr);
                }
                curr = new NestedInteger();
                start = i + 1;
            } else if (c == ']') {
                String num = s.substring(start, i);
                if (!num.isEmpty()) {
                    curr.add(new NestedInteger(Integer.parseInt(num)));
                }
                if (!stack.isEmpty()) {
                    NestedInteger pop = stack.pop();
                    pop.add(curr);
                    curr = pop;
                }
                start = i + 1;
            } else if (c == ',') {
                if (s.charAt(i - 1) != ']') {
                    String num = s.substring(start, i);
                    curr.add(new NestedInteger(Integer.parseInt(num)));
                }
                start = i + 1;
            }
        }
        return curr;
    }
}