public class Solution {

import java.util.*;

public class Solution {
    public TreeNode buildBinaryTree(int[][] descriptions) {
        Map<Integer, TreeNode> nodeMap = new HashMap<>();
        Set<Integer> children = new HashSet<>();

        for (int[] desc : descriptions) {
            int parentVal = desc[0];
            int childVal = desc[1];
            boolean isLeft = desc[2] == 1;

            nodeMap.putIfAbsent(parentVal, new TreeNode(parentVal));
            nodeMap.putIfAbsent(childVal, new TreeNode(childVal));

            TreeNode parent = nodeMap.get(parentVal);
            TreeNode child = nodeMap.get(childVal);

            if (isLeft) {
                parent.left = child;
            } else {
                parent.right = child;
            }

            children.add(childVal);
        }

        for (Map.Entry<Integer, TreeNode> entry : nodeMap.entrySet()) {
            if (!children.contains(entry.getKey())) {
                return entry.getValue();
            }
        }

        return null;
    }

    public static class TreeNode {
        int val;
        TreeNode left;
        TreeNode right;

        TreeNode(int x) {
            val = x;
        }
    }
}
}