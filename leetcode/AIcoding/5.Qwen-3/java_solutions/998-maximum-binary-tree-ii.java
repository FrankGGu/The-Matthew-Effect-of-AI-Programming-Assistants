public class Solution {

class Solution {
    public TreeNode constructMaximumBinaryTree(TreeNode root, int val) {
        return insert(root, val);
    }

    private TreeNode insert(TreeNode node, int val) {
        if (node == null || val > node.val) {
            TreeNode newNode = new TreeNode(val);
            newNode.left = node;
            return newNode;
        }

        node.right = insert(node.right, val);
        return node;
    }
}
}