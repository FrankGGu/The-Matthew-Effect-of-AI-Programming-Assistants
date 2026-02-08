import java.util.ArrayList;
import java.util.List;

public class Solution {
    public List<TreeNode> allPossibleFBT(int n) {
        if (n % 2 == 0) return new ArrayList<>(); 
        return allPossibleFBTHelper(n);
    }

    private List<TreeNode> allPossibleFBTHelper(int n) {
        if (n == 1) {
            List<TreeNode> result = new ArrayList<>();
            result.add(new TreeNode(0));
            return result;
        }
        List<TreeNode> result = new ArrayList<>();
        for (int left = 1; left < n; left += 2) {
            int right = n - 1 - left;
            List<TreeNode> leftTrees = allPossibleFBTHelper(left);
            List<TreeNode> rightTrees = allPossibleFBTHelper(right);
            for (TreeNode leftTree : leftTrees) {
                for (TreeNode rightTree : rightTrees) {
                    TreeNode root = new TreeNode(0);
                    root.left = leftTree;
                    root.right = rightTree;
                    result.add(root);
                }
            }
        }
        return result;
    }
}

class TreeNode {
    int val;
    TreeNode left;
    TreeNode right;
    TreeNode(int x) { val = x; }
}