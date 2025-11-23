public class Solution {

import java.util.*;

public class Solution {
    public int[][] getDirections(TreeNode root, int startValue, int destValue) {
        List<TreeNode> pathToStart = new ArrayList<>();
        List<TreeNode> pathToDest = new ArrayList<>();

        findPath(root, startValue, pathToStart);
        findPath(root, destValue, pathToDest);

        int i = 0;
        while (i < pathToStart.size() && i < pathToDest.size() && pathToStart.get(i) == pathToDest.get(i)) {
            i++;
        }

        List<String> res = new ArrayList<>();
        for (int j = pathToStart.size() - 1; j >= i; j--) {
            res.add("U");
        }

        for (int j = i; j < pathToDest.size(); j++) {
            if (pathToDest.get(j).left == pathToDest.get(j - 1)) {
                res.add("L");
            } else {
                res.add("R");
            }
        }

        int[][] result = new int[res.size()][2];
        for (int k = 0; k < res.size(); k++) {
            result[k][0] = res.get(k).charAt(0) == 'U' ? 0 : 1;
            result[k][1] = res.get(k).charAt(0) == 'L' ? 0 : 1;
        }

        return result;
    }

    private boolean findPath(TreeNode node, int target, List<TreeNode> path) {
        if (node == null) {
            return false;
        }
        path.add(node);
        if (node.val == target) {
            return true;
        }
        if (findPath(node.left, target, path)) {
            return true;
        }
        if (findPath(node.right, target, path)) {
            return true;
        }
        path.remove(path.size() - 1);
        return false;
    }
}
}