class Solution {
    private Map<TreeNode, TreeNode> parentMap;

    public List<Integer> distanceK(TreeNode root, TreeNode target, int k) {
        parentMap = new HashMap<>();
        buildParentMap(root, null);

        Queue<TreeNode> queue = new LinkedList<>();
        Set<TreeNode> visited = new HashSet<>();
        queue.offer(target);
        visited.add(target);

        int distance = 0;
        while (!queue.isEmpty()) {
            if (distance == k) {
                break;
            }
            int size = queue.size();
            for (int i = 0; i < size; i++) {
                TreeNode current = queue.poll();
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

        List<Integer> result = new ArrayList<>();
        while (!queue.isEmpty()) {
            result.add(queue.poll().val);
        }
        return result;
    }

    private void buildParentMap(TreeNode node, TreeNode parent) {
        if (node == null) {
            return;
        }
        parentMap.put(node, parent);
        buildParentMap(node.left, node);
        buildParentMap(node.right, node);
    }
}