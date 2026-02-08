public class Solution {


class TreeNode {
    int val;
    TreeNode left;
    TreeNode right;

    TreeNode(int x) {
        val = x;
    }
}

import java.util.*;

public class Solution {
    List<String> result = new ArrayList<>();
    int index = 0;

    public List<String> flipMatchVoyage(TreeNode root, int[] voyage) {
        if (dfs(root, voyage)) {
            return result;
        } else {
            return Arrays.asList("-1");
        }
    }

    private boolean dfs(TreeNode node, int[] voyage) {
        if (node == null) {
            return true;
        }
        if (node.val != voyage[index++]) {
            return false;
        }
        if (node.left != null && node.left.val != voyage[index]) {
            TreeNode temp = node.left;
            node.left = node.right;
            node.right = temp;
            result.add(String.valueOf(node.val));
        }
        if (!dfs(node.left, voyage)) {
            return false;
        }
        return dfs(node.right, voyage);
    }
}
}