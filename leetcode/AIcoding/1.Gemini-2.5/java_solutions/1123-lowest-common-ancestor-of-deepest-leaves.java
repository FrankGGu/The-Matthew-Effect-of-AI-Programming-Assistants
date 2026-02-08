class Solution {
    class Result {
        TreeNode node;
        int depth;

        Result(TreeNode node, int depth) {
            this.node = node;
            this.depth = depth;
        }
    }

    public TreeNode lcaDeepestLeaves(TreeNode root) {
        return dfs(root).node;
    }

    private Result dfs(TreeNode node) {
        if (node == null) {
            return new Result(null, 0);
        }

        Result leftResult = dfs(node.left);
        Result rightResult = dfs(node.right);

        if (leftResult.depth == rightResult.depth) {
            return new Result(node, leftResult.depth + 1);
        } else if (leftResult.depth > rightResult.depth) {
            return new Result(leftResult.node, leftResult.depth + 1);
        } else {
            return new Result(rightResult.node, rightResult.depth + 1);
        }
    }
}