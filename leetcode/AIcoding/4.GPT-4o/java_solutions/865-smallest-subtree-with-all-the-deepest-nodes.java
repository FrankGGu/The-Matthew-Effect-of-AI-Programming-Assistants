class TreeNode {
    int val;
    TreeNode left;
    TreeNode right;
    TreeNode(int x) { val = x; }
}

class Solution {
    public TreeNode subtreeWithAllDeepest(TreeNode root) {
        return dfs(root).node;
    }

    private Result dfs(TreeNode node) {
        if (node == null) {
            return new Result(0, null);
        }

        Result left = dfs(node.left);
        Result right = dfs(node.right);

        if (left.depth > right.depth) {
            return new Result(left.depth + 1, left.node);
        } else if (left.depth < right.depth) {
            return new Result(right.depth + 1, right.node);
        } else {
            return new Result(left.depth + 1, node);
        }
    }

    private class Result {
        int depth;
        TreeNode node;

        Result(int depth, TreeNode node) {
            this.depth = depth;
            this.node = node;
        }
    }
}