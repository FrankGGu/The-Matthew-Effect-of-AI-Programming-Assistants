import java.util.*;

class Solution {
    class Pair {
        TreeNode node;
        int x, y;
        Pair(TreeNode n, int x, int y) {
            this.node = n;
            this.x = x;
            this.y = y;
        }
    }

    public List<List<Integer>> verticalTraversal(TreeNode root) {
        List<List<Integer>> result = new ArrayList<>();
        Map<Integer, List<Pair>> map = new HashMap<>();
        Queue<Pair> queue = new LinkedList<>();
        queue.offer(new Pair(root, 0, 0));

        while (!queue.isEmpty()) {
            int size = queue.size();
            Map<Integer, List<Integer>> tempMap = new TreeMap<>();
            for (int i = 0; i < size; i++) {
                Pair pair = queue.poll();
                int x = pair.x;
                int y = pair.y;
                if (!tempMap.containsKey(x)) {
                    tempMap.put(x, new ArrayList<>());
                }
                tempMap.get(x).add(pair.node.val);
                if (pair.node.left != null) {
                    queue.offer(new Pair(pair.node.left, x - 1, y + 1));
                }
                if (pair.node.right != null) {
                    queue.offer(new Pair(pair.node.right, x + 1, y + 1));
                }
            }
            for (List<Integer> values : tempMap.values()) {
                Collections.sort(values);
                result.add(values);
            }
        }

        return result;
    }
}