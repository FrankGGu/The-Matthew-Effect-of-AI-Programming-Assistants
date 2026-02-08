import java.util.*;

class Solution {
    Map<TreeNode, TreeNode> parentMap;

    public List<Integer> distanceK(TreeNode root, TreeNode target, int k) {
        parentMap = new HashMap<>();
        findParents(root, null);

        List<Integer> result = new ArrayList<>();
        Queue<TreeNode> queue = new LinkedList<>();
        Set<TreeNode> visited = new HashSet<>();

        queue.offer(target);
        visited.add(target);
        int distance = 0;

        while (!queue.isEmpty() && distance <= k) {
            int levelSize = queue.size();
            for (int i = 0; i < levelSize; i++) {
                TreeNode current = queue.poll();

                if (distance == k) {
                    result.add(current.val);
                }

                if (current.left != null && !visited.contains(current.left)) {
                    queue.offer(current.left);
                    visited.add(current.left);
                }
                if (current.right != null && !visited.contains(current.right)) {
                    queue.offer(current.right);
                    visited.add(current.right);
                }
                TreeNode parent = parentMap.get(current);
                if (parent != null && !visited.contains(parent)) {
                    queue.offer(parent);
                    visited.add(parent);
                }
            }
            distance++;
        }

        return result;
    }

    private void findParents(TreeNode node, TreeNode parent) {
        if (node == null) {
            return;
        }
        parentMap.put(node, parent);
        findParents(node.left, node);
        findParents(node.right, node);
    }
}