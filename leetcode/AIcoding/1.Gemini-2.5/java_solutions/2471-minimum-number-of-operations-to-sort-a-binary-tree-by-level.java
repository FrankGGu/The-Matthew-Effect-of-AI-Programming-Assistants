import java.util.*;

class Solution {
    public int minimumOperations(TreeNode root) {
        if (root == null) {
            return 0;
        }

        int totalOperations = 0;
        Queue<TreeNode> queue = new LinkedList<>();
        queue.offer(root);

        while (!queue.isEmpty()) {
            int levelSize = queue.size();
            List<Integer> currentLevelValues = new ArrayList<>();
            for (int i = 0; i < levelSize; i++) {
                TreeNode node = queue.poll();
                currentLevelValues.add(node.val);
                if (node.left != null) {
                    queue.offer(node.left);
                }
                if (node.right != null) {
                    queue.offer(node.right);
                }
            }

            totalOperations += minSwapsToSort(currentLevelValues);
        }

        return totalOperations;
    }

    private int minSwapsToSort(List<Integer> arr) {
        int n = arr.size();
        if (n <= 1) {
            return 0;
        }

        List<Pair<Integer, Integer>> pairs = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            pairs.add(new Pair<>(arr.get(i), i));
        }

        Collections.sort(pairs, (a, b) -> a.key - b.key);

        boolean[] visited = new boolean[n];
        int swaps = 0;

        for (int i = 0; i < n; i++) {
            if (visited[i] || pairs.get(i).value == i) {
                continue;
            }

            int cycleSize = 0;
            int j = i;
            while (!visited[j]) {
                visited[j] = true;
                j = pairs.get(j).value;
                cycleSize++;
            }
            swaps += (cycleSize - 1);
        }
        return swaps;
    }

    private static class Pair<K, V> {
        K key;
        V value;

        public Pair(K key, V value) {
            this.key = key;
            this.value = value;
        }
    }
}