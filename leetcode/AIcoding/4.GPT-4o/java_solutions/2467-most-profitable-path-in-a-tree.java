import java.util.*;

class Solution {
    public List<Integer> mostProfitablePath(int[][] edges, int bob, int target, int[] amount) {
        Map<Integer, List<int[]>> graph = new HashMap<>();
        for (int[] edge : edges) {
            graph.putIfAbsent(edge[0], new ArrayList<>());
            graph.putIfAbsent(edge[1], new ArrayList<>());
            graph.get(edge[0]).add(new int[]{edge[1], amount[edge[1]]});
            graph.get(edge[1]).add(new int[]{edge[0], amount[edge[0]]});
        }

        int[] bobDist = new int[amount.length];
        Arrays.fill(bobDist, Integer.MAX_VALUE);
        bobDist[bob] = 0;
        bfs(bob, graph, bobDist);

        int[] maxProfit = new int[1];
        maxProfit[0] = Integer.MIN_VALUE;
        List<Integer> path = new ArrayList<>();
        dfs(target, graph, bobDist, 0, new ArrayList<>(), path, maxProfit, 0, amount);

        return path;
    }

    private void bfs(int bob, Map<Integer, List<int[]>> graph, int[] bobDist) {
        Queue<Integer> queue = new LinkedList<>();
        queue.add(bob);
        int distance = 0;
        while (!queue.isEmpty()) {
            int size = queue.size();
            for (int i = 0; i < size; i++) {
                int curr = queue.poll();
                for (int[] neighbor : graph.get(curr)) {
                    if (bobDist[neighbor[0]] == Integer.MAX_VALUE) {
                        bobDist[neighbor[0]] = distance + 1;
                        queue.add(neighbor[0]);
                    }
                }
            }
            distance++;
        }
    }

    private void dfs(int node, Map<Integer, List<int[]>> graph, int[] bobDist, int currProfit, List<Integer> path, List<Integer> bestPath, int[] maxProfit, int step, int[] amount) {
        path.add(node);
        currProfit += amount[node];
        if (node == 0) {
            if (currProfit > maxProfit[0]) {
                maxProfit[0] = currProfit;
                bestPath.clear();
                bestPath.addAll(path);
            }
        } else {
            for (int[] neighbor : graph.get(node)) {
                if (bobDist[neighbor[0]] == step + 1) {
                    dfs(neighbor[0], graph, bobDist, currProfit - amount[node], path, bestPath, maxProfit, step + 1, amount);
                } else if (bobDist[neighbor[0]] > step + 1) {
                    dfs(neighbor[0], graph, bobDist, currProfit, path, bestPath, maxProfit, step + 1, amount);
                }
            }
        }
        path.remove(path.size() - 1);
    }
}