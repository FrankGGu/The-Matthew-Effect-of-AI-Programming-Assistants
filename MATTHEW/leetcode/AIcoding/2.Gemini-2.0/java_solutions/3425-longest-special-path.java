import java.util.*;

class Solution {
    public int longestSpecialPath(int[] parent, int[] values) {
        int n = parent.length;
        List<List<Integer>> adj = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            adj.add(new ArrayList<>());
        }
        for (int i = 1; i < n; i++) {
            adj.get(i).add(parent[i]);
            adj.get(parent[i]).add(i);
        }

        int maxLen = 0;

        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                if (i == j) continue;

                Queue<List<Integer>> q = new LinkedList<>();
                q.offer(Arrays.asList(i));
                Set<Integer> visited = new HashSet<>();
                visited.add(i);

                while (!q.isEmpty()) {
                    List<Integer> path = q.poll();
                    int lastNode = path.get(path.size() - 1);

                    if (lastNode == j) {
                        boolean special = true;
                        Set<Integer> pathValues = new HashSet<>();
                        for (int node : path) {
                            if (pathValues.contains(values[node])) {
                                special = false;
                                break;
                            }
                            pathValues.add(values[node]);
                        }
                        if (special) {
                            maxLen = Math.max(maxLen, path.size());
                        }
                    } else {
                        for (int neighbor : adj.get(lastNode)) {
                            if (!visited.contains(neighbor)) {
                                List<Integer> newPath = new ArrayList<>(path);
                                newPath.add(neighbor);
                                q.offer(newPath);
                                visited.add(neighbor);
                            }
                        }
                    }
                }
            }
        }

        return maxLen;
    }
}