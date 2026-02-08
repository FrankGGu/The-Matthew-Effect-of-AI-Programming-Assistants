public class Solution {


class TreeNode {
    int val;
    TreeNode left;
    TreeNode right;
    TreeNode() {}
    TreeNode(int val) { this.val = val; }
    TreeNode(int val, TreeNode left, TreeNode right) {
        this.val = val;
        this.left = left;
        this.right = right;
    }
}

public class Solution {
    public TreeNode recoverFromPreorder(String s) {
        return recover(s, 0);
    }

    private TreeNode recover(String s, int depth) {
        int i = 0;
        while (i < s.length() && s.charAt(i) != '-') {
            i++;
        }
        int val = Integer.parseInt(s.substring(0, i));
        TreeNode node = new TreeNode(val);
        if (i == s.length()) {
            return node;
        }
        int nextDepth = 0;
        while (i < s.length() && s.charAt(i) == '-') {
            nextDepth++;
            i++;
        }
        if (nextDepth == depth + 1) {
            node.left = recover(s.substring(i), nextDepth);
        } else {
            node.right = recover(s.substring(i), nextDepth);
        }
        return node;
    }
}
}