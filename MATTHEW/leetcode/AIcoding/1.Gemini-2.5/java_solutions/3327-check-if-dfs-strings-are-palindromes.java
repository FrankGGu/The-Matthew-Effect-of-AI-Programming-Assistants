import java.util.ArrayList;
import java.util.List;

class Solution {

    public boolean checkDFSStringsArePalindromes(TreeNode root) {
        if (root == null) {
            return true;
        }
        return dfs(root, new ArrayList<>());
    }

    private boolean dfs(TreeNode node, List<Integer> currentPath) {
        currentPath.add(node.val);

        if (node.left == null && node.right == null) {
            boolean isPathPalindrome = isPalindrome(currentPath);
            currentPath.remove(currentPath.size() - 1);
            return isPathPalindrome;
        }

        boolean leftResult = true;
        boolean rightResult = true;

        if (node.left != null) {
            leftResult = dfs(node.left, currentPath);
            if (!leftResult) {
                currentPath.remove(currentPath.size() - 1);
                return false;
            }
        }

        if (node.right != null) {
            rightResult = dfs(node.right, currentPath);
            if (!rightResult) {
                currentPath.remove(currentPath.size() - 1);
                return false;
            }
        }

        currentPath.remove(currentPath.size() - 1);
        return leftResult && rightResult;
    }

    private boolean isPalindrome(List<Integer> path) {
        int left = 0;
        int right = path.size() - 1;
        while (left < right) {
            if (!path.get(left).equals(path.get(right))) {
                return false;
            }
            left++;
            right--;
        }
        return true;
    }
}