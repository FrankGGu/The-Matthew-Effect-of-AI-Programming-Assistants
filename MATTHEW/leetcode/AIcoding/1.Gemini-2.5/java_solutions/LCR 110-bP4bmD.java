import java.util.ArrayList;
import java.util.List;

class Solution {
    public List<List<Integer>> allPathsSourceTarget(int[][] graph) {
        List<List<Integer>> allPaths = new ArrayList<>();
        List<Integer> currentPath = new ArrayList<>();

        dfs(graph, 0, graph.length - 1, currentPath, allPaths);

        return allPaths;
    }

    private void dfs(int[][] graph, int currentNode, int targetNode, List<Integer> currentPath, List<List<Integer>> allPaths) {
        currentPath.add(currentNode);

        if (currentNode == targetNode) {
            allPaths.add(new ArrayList<>(currentPath));
        } else {
            for (int neighbor : graph[currentNode]) {
                dfs(graph, neighbor, targetNode, currentPath, allPaths);
            }
        }

        currentPath.remove(currentPath.size() - 1);
    }
}