import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

class Solution {
    public TreeNode createBinaryTree(int[][] descriptions) {
        Map<Integer, TreeNode> nodeMap = new HashMap<>();
        Set<Integer> children = new HashSet<>();

        for (int[] desc : descriptions) {
            int parentVal = desc[0];
            int childVal = desc[1];
            boolean isLeft = desc[2] == 1;

            TreeNode parent = nodeMap.getOrDefault(parentVal, new TreeNode(parentVal));
            TreeNode child = nodeMap.getOrDefault(childVal, new TreeNode(childVal));

            if (isLeft) {
                parent.left = child;
            } else {
                parent.right = child;
            }

            nodeMap.put(parentVal, parent);
            nodeMap.put(childVal, child);
            children.add(childVal);
        }

        for (int key : nodeMap.keySet()) {
            if (!children.contains(key)) {
                return nodeMap.get(key);
            }
        }

        return null;
    }
}

class TreeNode {
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