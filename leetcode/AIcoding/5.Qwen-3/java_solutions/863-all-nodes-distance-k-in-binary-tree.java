public class Solution {

import java.util.*;

public class Solution {
    public List<Integer> distanceK(TreeNode root, TreeNode target, int K) {
        Map<TreeNode, TreeNode> parentMap = new HashMap<>();
        findParents(root, parentMap);
        List<Integer> result = new ArrayList<>();
        Set<TreeNode> visited = new HashSet<>();
        Queue<TreeNode> queue = new LinkedList<>();
        queue.add(target);
        visited.add(target);
        int level = 0;
        while (!queue.isEmpty()) {
            int size = queue.size();
            for (int i = 0; i < size; i++) {
                TreeNode node = queue.poll();
                if (level == K) {
                    result.add(node.val);
                }
                if (node.left != null && !visited.contains(node.left)) {
                    visited.add(node.left);
                    queue.add(node.left);
                }
                if (node.right != null && !visited.contains(node.right)) {
                    visited.add(node.right);
                    queue.add(node.right);
                }
                TreeNode parent = parentMap.get(node);
                if (parent != null && !visited.contains(parent)) {
                    visited.add(parent);
                    queue.add(parent);
                }
            }
            if (level == K) break;
            level++;
        }
        return result;
    }

    private void findParents(TreeNode node, Map<TreeNode, TreeNode> parentMap) {
        if (node == null) return;
        if (node.left != null) {
            parentMap.put(node.left, node);
            findParents(node.left, parentMap);
        }
        if (node.right != null) {
            parentMap.put(node.right, node);
            findParents(node.right, parentMap);
        }
    }

    public class TreeNode {
        int val;
        TreeNode left;
        TreeNode right;
        TreeNode(int x) { val = x; }
    }
}
}