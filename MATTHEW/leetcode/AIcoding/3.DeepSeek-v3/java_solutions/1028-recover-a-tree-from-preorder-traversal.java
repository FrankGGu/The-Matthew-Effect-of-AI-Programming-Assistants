class Solution {
    public TreeNode recoverFromPreorder(String S) {
        Stack<TreeNode> stack = new Stack<>();
        int i = 0;
        while (i < S.length()) {
            int level = 0;
            while (i < S.length() && S.charAt(i) == '-') {
                level++;
                i++;
            }
            int val = 0;
            while (i < S.length() && Character.isDigit(S.charAt(i))) {
                val = val * 10 + (S.charAt(i) - '0');
                i++;
            }
            TreeNode node = new TreeNode(val);
            if (level == stack.size()) {
                if (!stack.isEmpty()) {
                    stack.peek().left = node;
                }
            } else {
                while (level != stack.size()) {
                    stack.pop();
                }
                stack.peek().right = node;
            }
            stack.push(node);
        }
        while (stack.size() > 1) {
            stack.pop();
        }
        return stack.pop();
    }
}