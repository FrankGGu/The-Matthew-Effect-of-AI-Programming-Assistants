public class Solution {

import java.util.*;

public class Solution {
    public int minJumps(int[] arr) {
        Map<Integer, List<Integer>> graph = new HashMap<>();
        for (int i = 0; i < arr.length; i++) {
            graph.putIfAbsent(arr[i], new ArrayList<>());
            graph.get(arr[i]).add(i);
        }

        Queue<Integer> queue = new LinkedList<>();
        boolean[] visited = new boolean[arr.length];
        queue.add(0);
        visited[0] = true;
        int steps = 0;

        while (!queue.isEmpty()) {
            int size = queue.size();
            for (int i = 0; i < size; i++) {
                int index = queue.poll();
                if (index == arr.length - 1) {
                    return steps;
                }
                for (int neighbor : graph.get(arr[index])) {
                    if (!visited[neighbor]) {
                        visited[neighbor] = true;
                        queue.add(neighbor);
                    }
                }
                graph.get(arr[index]).clear();
                if (index + 1 < arr.length && !visited[index + 1]) {
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
}