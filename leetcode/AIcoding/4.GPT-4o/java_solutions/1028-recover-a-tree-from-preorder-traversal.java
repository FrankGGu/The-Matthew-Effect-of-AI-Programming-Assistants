import java.util.Stack;

public class Solution {
    public TreeNode recoverFromPreorder(String S) {
        Stack<TreeNode> stack = new Stack<>();
        int i = 0;

        while (i < S.length()) {
            int level = 0;
            while (i < S.length() && S.charAt(i) == '-') {
                level++;
                i++;
            }
            int value = 0;
            while (i < S.length() && Character.isDigit(S.charAt(i))) {
                value = value * 10 + (S.charAt(i) - '0');
                i++;
            }
            TreeNode node = new TreeNode(value);
            if (level == stack.size()) {
                if (!stack.isEmpty()) {
                    stack.peek().left = node;
                }
            } else {
                while (stack.size() > level) {
                    stack.pop();
                }
                stack.peek().right = node;
            }
            stack.push(node);
        }

        return stack.get(0);
    }
}

class TreeNode {
    int val;
    TreeNode left;
    TreeNode right;
    TreeNode(int x) { val = x; }
}