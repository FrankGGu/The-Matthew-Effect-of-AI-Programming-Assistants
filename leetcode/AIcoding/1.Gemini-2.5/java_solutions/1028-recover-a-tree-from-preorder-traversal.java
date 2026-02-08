import java.util.Stack;

class Solution {
    public TreeNode recoverFromPreorder(String traversal) {
        Stack<TreeNode> stack = new Stack<>();
        int i = 0;
        while (i < traversal.length()) {
            int depth = 0;
            while (i < traversal.length() && traversal.charAt(i) == '-') {
                depth++;
                i++;
            }

            int value = 0;
            while (i < traversal.length() && Character.isDigit(traversal.charAt(i))) {
                value = value * 10 + (traversal.charAt(i) - '0');
                i++;
            }

            TreeNode node = new TreeNode(value);

            // The stack maintains the path from the root to the current parent.
            // The depth of a node at index `k` in the stack (0-indexed) is `k`.
            // If the current node is at `depth`, its parent must be at `depth - 1`.
            // So, we need to pop nodes until the stack size equals `depth`.
            // The node at `stack.peek()` will then be the parent.
            while (stack.size() > depth) {
                stack.pop();
            }

            if (!stack.isEmpty()) {
                TreeNode parent = stack.peek();
                if (parent.left == null) {
                    parent.left = node;
                } else {
                    parent.right = node;
                }
            }
            stack.push(node);
        }

        // The root node is the first node pushed onto the stack and will remain at the bottom.
        return stack.isEmpty() ? null : stack.firstElement();
    }
}