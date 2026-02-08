import java.util.*;

class Solution {
    public int minimumOperations(TreeNode root) {
        if (root == null) {
            return 0;
        }

        int operations = 0;
        Queue<TreeNode> queue = new LinkedList<>();
        queue.offer(root);

        while (!queue.isEmpty()) {
            int size = queue.size();
            List<Integer> levelValues = new ArrayList<>();

            for (int i = 0; i < size; i++) {
                TreeNode node = queue.poll();
                levelValues.add(node.val);

                if (node.left != null) {
                    queue.offer(node.left);
                }
                if (node.right != null) {
                    queue.offer(node.right);
                }
            }

            operations += countSwaps(levelValues);
        }

        return operations;
    }

    private int countSwaps(List<Integer> nums) {
        int n = nums.size();
        int[] arr = new int[n];
        for (int i = 0; i < n; i++) {
            arr[i] = nums.get(i);
        }

        Map<Integer, Integer> valToIndex = new HashMap<>();
        for (int i = 0; i < n; i++) {
            valToIndex.put(arr[i], i);
        }

        Arrays.sort(arr);

        int swaps = 0;
        boolean[] visited = new boolean[n];

        for (int i = 0; i < n; i++) {
            if (visited[i] || nums.get(i) == arr[i]) {
                continue;
            }

            int cycleSize = 0;
            int j = i;
            while (!visited[j]) {
                visited[j] = true;
                j = valToIndex.get(arr[j]);
                cycleSize++;
            }

            if (cycleSize > 0) {
                swaps += (cycleSize - 1);
            }
        }

        return swaps;
    }
}