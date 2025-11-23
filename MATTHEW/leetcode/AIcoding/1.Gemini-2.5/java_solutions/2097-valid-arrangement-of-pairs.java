import java.util.*;

class Solution {
    public int[][] validArrangement(int[][] pairs) {
        Map<Integer, Deque<Integer>> adj = new HashMap<>();
        Map<Integer, Integer> outDegree = new HashMap<>();
        Map<Integer, Integer> inDegree = new HashMap<>();

        for (int[] pair : pairs) {
            int u = pair[0];
            int v = pair[1];
            adj.computeIfAbsent(u, k -> new ArrayDeque<>()).addLast(v);
            outDegree.put(u, outDegree.getOrDefault(u, 0) + 1);
            inDegree.put(v, inDegree.getOrDefault(v, 0) + 1);
            // Ensure all nodes involved are in degree maps even if they only have in-degree or out-degree
            outDegree.putIfAbsent(v, 0);
            inDegree.putIfAbsent(u, 0);
        }

        int startNode = pairs[0][0]; // Default start node
        for (int node : outDegree.keySet()) {
            if (outDegree.get(node) == inDegree.get(node) + 1) {
                startNode = node;
                break;
            }
        }

        Deque<Integer> path = new ArrayDeque<>();

        dfs(startNode, adj, path);

        int[][] result = new int[pairs.length][2];
        int i = pairs.length - 1; // Fill from end because path is built in reverse
        int prev = path.removeFirst();
        while (!path.isEmpty()) {
            int curr = path.removeFirst();
            result[i][0] = curr;
            result[i][1] = prev;
            prev = curr;
            i--;
        }
        // The path is built in reverse order of traversal (end to start).
        // For example, if path is [D, C, B, A] for A->B->C->D,
        // we add A, then B, then C, then D.
        // The `path.addFirst(u)` in dfs adds the nodes in reverse order of discovery.
        // So, if the path is A -> B -> C, the `path` deque will be [C, B, A] after dfs.
        // We need to iterate from the back of the path to construct the pairs correctly.
        // Let's re-evaluate the path construction.
        // If path is [A, B, C, D] (start to end), then pairs are [A,B], [B,C], [C,D].
        // The `dfs` adds nodes to the front of the `path` deque.
        // Example: A -> B -> C
        // dfs(C) -> path.addFirst(C) -> path = [C]
        // dfs(B) -> path.addFirst(B) -> path = [B, C]
        // dfs(A) -> path.addFirst(A) -> path = [A, B, C]
        // So the path is indeed constructed as [start, ..., end].
        // My previous result construction was correct.

        // Re-doing result construction based on path being [start, ..., end]
        i = 0;
        int currentPrev = path.removeFirst(); // This is the actual start node
        while (!path.isEmpty()) {
            int currentNext = path.removeFirst();
            result[i][0] = currentPrev;
            result[i][1] = currentNext;
            currentPrev = currentNext;
            i++;
        }

        return result;
    }

    private void dfs(int u, Map<Integer, Deque<Integer>> adj, Deque<Integer> path) {
        Deque<Integer> neighbors = adj.get(u);
        while (neighbors != null && !neighbors.isEmpty()) {
            int v = neighbors.removeFirst(); // Remove edge
            dfs(v, adj, path);
        }
        path.addFirst(u); // Add to front of path (reverse order of traversal)
    }
}