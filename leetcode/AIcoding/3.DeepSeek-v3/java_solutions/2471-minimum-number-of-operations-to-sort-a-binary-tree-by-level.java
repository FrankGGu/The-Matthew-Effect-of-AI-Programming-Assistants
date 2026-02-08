class Solution {
    public int minimumOperations(TreeNode root) {
        if (root == null) return 0;
        Queue<TreeNode> queue = new LinkedList<>();
        queue.offer(root);
        int res = 0;

        while (!queue.isEmpty()) {
            int size = queue.size();
            List<Integer> level = new ArrayList<>();
            for (int i = 0; i < size; i++) {
                TreeNode node = queue.poll();
                level.add(node.val);
                if (node.left != null) queue.offer(node.left);
                if (node.right != null) queue.offer(node.right);
            }
            res += minSwaps(level);
        }
        return res;
    }

    private int minSwaps(List<Integer> list) {
        int n = list.size();
        int[] arr = new int[n];
        for (int i = 0; i < n; i++) {
            arr[i] = list.get(i);
        }
        int[] sorted = Arrays.copyOf(arr, n);
        Arrays.sort(sorted);
        Map<Integer, Integer> map = new HashMap<>();
        for (int i = 0; i < n; i++) {
            map.put(sorted[i], i);
        }
        boolean[] visited = new boolean[n];
        int swaps = 0;
        for (int i = 0; i < n; i++) {
            if (!visited[i]) {
                int j = i;
                int cycleSize = 0;
                while (!visited[j]) {
                    visited[j] = true;
                    j = map.get(arr[j]);
                    cycleSize++;
                }
                swaps += cycleSize - 1;
            }
        }
        return swaps;
    }
}