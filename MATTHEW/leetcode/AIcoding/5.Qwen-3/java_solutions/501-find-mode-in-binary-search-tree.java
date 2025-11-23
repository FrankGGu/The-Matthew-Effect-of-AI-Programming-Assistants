public class Solution {

import java.util.*;

class TreeNode {
    int val;
    TreeNode left;
    TreeNode right;
    TreeNode(int x) { val = x; }
}

public class Solution {
    private int prev;
    private int count;
    private int maxCount;
    private List<Integer> mode;

    public int[] findMode(TreeNode root) {
        mode = new ArrayList<>();
        inOrder(root);
        int[] result = new int[mode.size()];
        for (int i = 0; i < result.length; i++) {
            result[i] = mode.get(i);
        }
        return result;
    }

    private void inOrder(TreeNode node) {
        if (node == null) return;
        inOrder(node.left);
        if (node.val == prev) {
            count++;
        } else {
            prev = node.val;
            count = 1;
        }
        if (count > maxCount) {
            maxCount = count;
            mode.clear();
            mode.add(node.val);
        } else if (count == maxCount) {
            mode.add(node.val);
        }
        inOrder(node.right);
    }
}
}