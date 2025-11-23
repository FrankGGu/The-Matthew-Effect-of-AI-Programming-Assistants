import java.util.*;

class Solution {
    public List<Boolean> checkIfPrerequisite(int n, int[][] prerequisites, int[][] queries) {
        List<Boolean> result = new ArrayList<>();
        List<List<Integer>> graph = new ArrayList<>();
        for (int i = 0; i < n; i++) graph.add(new ArrayList<>());
        boolean[][] reachable = new boolean[n][n];

        for (int[] prereq : prerequisites) {
            graph.get(prereq[0]).add(prereq[1]);
            reachable[prereq[0]][prereq[1]] = true;
        }

        for (int i = 0; i < n; i++) {
            bfs(graph, reachable, i);
        }

        for (int[] query : queries) {
            result.add(reachable[query[0]][query[1]]);
        }

        return result;
    }

    private void bfs(List<List<Integer>> graph, boolean[][] reachable, int start) {
        Queue<Integer> queue = new LinkedList<>();
        queue.offer(start);

        while (!queue.isEmpty()) {
            int curr = queue.poll();
            for (int neighbor : graph.get(curr)) {
                if (!reachable[start][neighbor]) {
                    reachable[start][neighbor] = true;
                    queue.offer(neighbor);
                }
            }
        }
    }
}