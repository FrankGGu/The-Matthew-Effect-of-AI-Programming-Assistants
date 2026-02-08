import java.util.HashMap;
import java.util.Map;

public class Solution {
    public TreeNode createBinaryTree(int[][] descriptions) {
        Map<Integer, TreeNode> nodes = new HashMap<>();
        Map<Integer, Boolean> isChild = new HashMap<>();

        for (int[] desc : descriptions) {
            int parentVal = desc[0];
            int childVal = desc[1];
            int isLeft = desc[2];

            TreeNode parentNode = nodes.computeIfAbsent(parentVal, TreeNode::new);
            TreeNode childNode = nodes.computeIfAbsent(childVal, TreeNode::new);

            if (isLeft == 1) {
                parentNode.left = childNode;
            } else {
                parentNode.right = childNode;
            }

            isChild.put(childVal, true);
        }

        TreeNode root = null;
        for (int[] desc : descriptions) {
            int parentVal = desc[0];
            if (!isChild.containsKey(parentVal)) {
                root = nodes.get(parentVal);
                break;
            }
        }

        return root;
    }

    public class TreeNode {
        int val;
        TreeNode left;
        TreeNode right;

        TreeNode() {
        }

        TreeNode(int val) {
            this.val = val;
        }

        TreeNode(int val, TreeNode left, TreeNode right) {
            this.val = val;
            this.left = left;
            this.right = right;
        }
    }
}