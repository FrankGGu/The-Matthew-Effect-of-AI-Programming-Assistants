import java.util.*;

public class Solution {
    public int minJumps(int[] arr) {
        int n = arr.length;
        if (n <= 1) return 0;

        Map<Integer, List<Integer>> graph = new HashMap<>();
        for (int i = 0; i < n; i++) {
            graph.computeIfAbsent(arr[i], k -> new ArrayList<>()).add(i);
        }

        boolean[] visited = new boolean[n];
        Queue<Integer> queue = new LinkedList<>();
        queue.add(0);
        visited[0] = true;
        int steps = 0;

        while (!queue.isEmpty()) {
            int size = queue.size();
            for (int i = 0; i < size; i++) {
                int index = queue.poll();
                if (index == n - 1) return steps;

                List<Integer> nextIndices = graph.get(arr[index]);
                if (nextIndices != null) {
                    for (int nextIndex : nextIndices) {
                        if (!visited[nextIndex]) {
                            visited[nextIndex] = true;
                            queue.add(nextIndex);
                        }
                    }
                    graph.remove(arr[index]);
                }

                if (index + 1 < n && !visited[index + 1]) {
                    visited[index + 1] = true;
                    queue.add(index + 1);
                }
                if (index - 1 >= 0 && !visited[index - 1]) {
                    visited[index - 1] = true;
                    queue.add(index - 1);
                }
            }
            steps++;
        }
        return -1;
    }
}