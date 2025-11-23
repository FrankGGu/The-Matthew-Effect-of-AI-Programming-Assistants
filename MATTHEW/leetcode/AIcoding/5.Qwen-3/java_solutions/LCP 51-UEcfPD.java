public class Solution {

import java.util.*;

public class Solution {
    public int numRounds(String[] dishes, String[] ingredients) {
        Map<String, Integer> dishMap = new HashMap<>();
        for (int i = 0; i < dishes.length; i++) {
            dishMap.put(dishes[i], i);
        }

        List<List<String>> graph = new ArrayList<>();
        for (int i = 0; i < dishes.length; i++) {
            graph.add(new ArrayList<>());
        }

        for (int i = 0; i < ingredients.length; i++) {
            String[] parts = ingredients[i].split(" ");
            String a = parts[0];
            String b = parts[1];
            if (dishMap.containsKey(a) && dishMap.containsKey(b)) {
                int u = dishMap.get(a);
                int v = dishMap.get(b);
                graph.get(u).add(b);
            }
        }

        boolean[] visited = new boolean[dishes.length];
        boolean[] recStack = new boolean[dishes.length];
        boolean hasCycle = false;

        for (int i = 0; i < dishes.length; i++) {
            if (!visited[i] && dfs(i, visited, recStack, graph)) {
                hasCycle = true;
                break;
            }
        }

        if (hasCycle) {
            return -1;
        }

        int[] inDegree = new int[dishes.length];
        for (int i = 0; i < dishes.length; i++) {
            for (String neighbor : graph.get(i)) {
                inDegree[dishMap.get(neighbor)]++;
            }
        }

        Queue<Integer> queue = new LinkedList<>();
        for (int i = 0; i < dishes.length; i++) {
            if (inDegree[i] == 0) {
                queue.add(i);
            }
        }

        int count = 0;
        while (!queue.isEmpty()) {
            int node = queue.poll();
            count++;
            for (String neighbor : graph.get(node)) {
                inDegree[dishMap.get(neighbor)]--;
                if (inDegree[dishMap.get(neighbor)] == 0) {
                    queue.add(dishMap.get(neighbor));
                }
            }
        }

        return count == dishes.length ? 1 : -1;
    }

    private boolean dfs(int node, boolean[] visited, boolean[] recStack, List<List<String>> graph) {
        if (recStack[node]) {
            return true;
        }
        if (visited[node]) {
            return false;
        }
        visited[node] = true;
        recStack[node] = true;
        for (String neighbor : graph.get(node)) {
            if (dfs(dishMap.get(neighbor), visited, recStack, graph)) {
                return true;
            }
        }
        recStack[node] = false;
        return false;
    }
}
}