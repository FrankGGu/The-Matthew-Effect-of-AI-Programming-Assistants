import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

class Solution {
    public TreeNode createBinaryTree(int[][] descriptions) {
        Map<Integer, TreeNode> nodes = new HashMap<>();
        Set<Integer> children = new HashSet<>();

        for (int[] description : descriptions) {
            int parentVal = description[0];
            int childVal = description[1];
            int isLeft = description[2];

            children.add(childVal);

            nodes.putIfAbsent(parentVal, new TreeNode(parentVal));
            nodes.putIfAbsent(childVal, new TreeNode(childVal));

            TreeNode parentNode = nodes.get(parentVal);
            TreeNode childNode = nodes.get(childVal);

            if (isLeft == 1) {
                parentNode.left = childNode;
            } else {
                parentNode.right = childNode;
            }
        }

        TreeNode root = null;
        for (Integer val : nodes.keySet()) {
            if (!children.contains(val)) {
                root = nodes.get(val);
                break;
            }
        }

        return root;
    }
}