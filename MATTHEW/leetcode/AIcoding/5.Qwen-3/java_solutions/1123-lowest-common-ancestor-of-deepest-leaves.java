public class Solution {
    public TreeNode lcaDeepestLeaves(TreeNode root) {
        return findLCA(root, 0).node;
    }

    private static class Pair {
        TreeNode node;
        int depth;

        Pair(TreeNode node, int depth) {
            this.node = node;
            this.depth = depth;
        }
    }

    private Pair findLCA(TreeNode node, int depth) {
        if (node == null) {
            return new Pair(null, -1);
        }

        Pair left = findLCA(node.left, depth + 1);
        Pair right = findLCA(node.right, depth + 1);

        if (left.depth == right.depth) {
            return new Pair(node, left.depth);
        } else if (left.depth > right.depth) {
            return left;
        } else {
            return right;
        }
    }
}