import java.util.*;

public class Solution {
    public List<Integer> flipMatchVoyage(TreeNode root, int[] voyage) {
        List<Integer> result = new ArrayList<>();
        if (dfs(root, voyage, new int[]{0}, result)) {
            return result;
        }
        return Arrays.asList(-1);
    }

    private boolean dfs(TreeNode node, int[] voyage, int[] index, List<Integer> result) {
        if (node == null) return true;
        if (node.val != voyage[index[0]++]) return false;

        if (node.left != null && node.left.val != voyage[index[0]]) {
            result.add(node.val);
            return dfs(node.right, voyage, index, result) && dfs(node.left, voyage, index, result);
        }
        return dfs(node.left, voyage, index, result) && dfs(node.right, voyage, index, result);
    }
}

class TreeNode {
    int val;
    TreeNode left;
    TreeNode right;
    TreeNode(int x) { val = x; }
}