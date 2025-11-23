import java.util.*;

class Solution {
    public int amountOfTime(TreeNode root, int start) {
        Map<Integer, List<Integer>> adj = new HashMap<>();
        Queue<TreeNode> q = new LinkedList<>();
        q.offer(root);

        while (!q.isEmpty()) {
            TreeNode node = q.poll();
            if (node.left != null) {
                adj.computeIfAbsent(node.val, k -> new ArrayList<>()).add(node.left.val);
                adj.computeIfAbsent(node.left.val, k -> new ArrayList<>()).add(node.val);
                q.offer(node.left);
            }
            if (node.right != null) {
                adj.computeIfAbsent(node.val, k -> new ArrayList<>()).add(node.right.val);
                adj.computeIfAbsent(node.right.val, k -> new ArrayList<>()).add(node.val);
                q.offer(node.right);
            }
        }

        Queue<Integer> bfsQ = new LinkedList<>();
        bfsQ.offer(start);
        Set<Integer> visited = new HashSet<>();
        visited.add(start);
        int time = 0;

        while (!bfsQ.isEmpty()) {
            int size = bfsQ.size();
            for (int i = 0; i < size; i++) {
                int u = bfsQ.poll();
                if (adj.containsKey(u)) {
                    for (int v : adj.get(u)) {
                        if (!visited.contains(v)) {
                            visited.add(v);
                            bfsQ.offer(v);
                        }
                    }
                }
            }
            if (!bfsQ.isEmpty()) {
                time++;
            }
        }

        return time;
    }
}