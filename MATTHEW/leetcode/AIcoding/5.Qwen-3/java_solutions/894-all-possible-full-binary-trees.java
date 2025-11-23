public class Solution {

import java.util.*;

public class Solution {
    public List<TreeNode> allPossibleFBT(int n) {
        Map<Integer, List<TreeNode>> memo = new HashMap<>();
        return helper(n, memo);
    }

    private List<TreeNode> helper(int n, Map<Integer, List<TreeNode>> memo) {
        if (memo.containsKey(n)) {
            return memo.get(n);
        }
        List<TreeNode> result = new ArrayList<>();
        if (n == 1) {
            result.add(new TreeNode(0));
            memo.put(1, result);
            return result;
        }
        for (int i = 1; i < n; i += 2) {
            List<TreeNode> leftTrees = helper(i, memo);
            List<TreeNode> rightTrees = helper(n - 1 - i, memo);
            for (TreeNode left : leftTrees) {
                for (TreeNode right : rightTrees) {
                    TreeNode root = new TreeNode(0);
                    root.left = left;
                    root.right = right;
                    result.add(root);
                }
            }
        }
        memo.put(n, result);
        return result;
    }

    static class TreeNode {
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
}
}