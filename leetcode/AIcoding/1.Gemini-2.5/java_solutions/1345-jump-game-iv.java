import java.util.*;

class Solution {
    public int minJumps(int[] arr) {
        int n = arr.length;
        if (n <= 1) {
            return 0;
        }

        Map<Integer, List<Integer>> graph = new HashMap<>();
        for (int i = 0; i < n; i++) {
            graph.computeIfAbsent(arr[i], k -> new ArrayList<>()).add(i);
        }

        Queue<int[]> queue = new LinkedList<>();
        queue.offer(new int[]{0, 0}); // {index, steps}

        boolean[] visited = new boolean[n];
        visited[0] = true;

        while (!queue.isEmpty()) {
            int[] current = queue.poll();
            int currIndex = current[0];
            int steps = current[1];

            if (currIndex == n - 1) {
                return steps;
            }

            // Option 1: Jump to i + 1
            if (currIndex + 1 < n && !visited[currIndex + 1]) {
                visited[currIndex + 1] = true;
                queue.offer(new int[]{currIndex + 1, steps + 1});
            }

            // Option 2: Jump to i - 1
            if (currIndex - 1 >= 0 && !visited[currIndex - 1]) {
                visited[currIndex - 1] = true;
                queue.offer(new int[]{currIndex - 1, steps + 1});
            }

            // Option 3: Jump to j such that arr[i] == arr[j]
            // Optimization: Clear the list after processing to avoid redundant checks
            if (graph.containsKey(arr[currIndex])) {
                for (int nextIndex : graph.get(arr[currIndex])) {
                    if (!visited[nextIndex]) {
                        visited[nextIndex] = true;
                        queue.offer(new int[]{nextIndex, steps + 1});
                    }
                }
                graph.remove(arr[currIndex]); // Clear the list for this value
            }
        }

        return -1; // Should not be reached if a path always exists to n-1
    }
}