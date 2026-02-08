public class Solution {

import java.util.*;

public class Solution {
    public int amountOfTime(TreeNode root, int start) {
        Map<TreeNode, TreeNode> parentMap = new HashMap<>();
        TreeNode startNode = findStartNode(root, start, parentMap);
        if (startNode == null) return 0;

        Queue<TreeNode> queue = new LinkedList<>();
        queue.add(startNode);
        Set<TreeNode> visited = new HashSet<>();
        visited.add(startNode);

        int time = 0;

        while (!queue.isEmpty()) {
            int size = queue.size();
            for (int i = 0; i < size; i++) {
                TreeNode current = queue.poll();
                if (current.left != null && !visited.contains(current.left)) {
                    visited.add(current.left);
                    queue.add(current.left);
                }
                if (current.right != null && !visited.contains(current.right)) {
                    visited.add(current.right);
                    queue.add(current.right);
                }
                TreeNode parent = parentMap.get(current);
                if (parent != null && !visited.contains(parent)) {
                    visited.add(parent);
                    queue.add(parent);
                }
            }
            time++;
        }

        return time - 1;
    }

    private TreeNode findStartNode(TreeNode node, int start, Map<TreeNode, TreeNode> parentMap) {
        if (node == null) return null;
        if (node.val == start) return node;

        if (node.left != null) {
            parentMap.put(node.left, node);
            TreeNode leftResult = findStartNode(node.left, start, parentMap);
            if (leftResult != null) return leftResult;
        }

        if (node.right != null) {
            parentMap.put(node.right, node);
            TreeNode rightResult = findStartNode(node.right, start, parentMap);
            if (rightResult != null) return rightResult;
        }

        return null;
    }

    static class TreeNode {
        int val;
        TreeNode left;
        TreeNode right;

        TreeNode(int x) {
            val = x;
        }
    }
}
}