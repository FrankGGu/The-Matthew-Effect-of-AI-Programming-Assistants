import java.util.*;

class Solution {
    public int[] countPairs(int n, int[][] edges, int signalSpeed) {
        List<List<int[]>> adj = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            adj.add(new ArrayList<>());
        }
        for (int[] edge : edges) {
            int u = edge[0];
            int v = edge[1];
            int w = edge[2];
            adj.get(u).add(new int[]{v, w});
            adj.get(v).add(new int[]{u, w});
        }

        int[] result = new int[n];
        for (int i = 0; i < n; i++) {
            List<Integer> distances = new ArrayList<>();
            for (int[] neighbor : adj.get(i)) {
                int neighborNode = neighbor[0];
                int weight = neighbor[1];
                Queue<int[]> q = new LinkedList<>();
                q.offer(new int[]{neighborNode, weight});
                Set<Integer> visited = new HashSet<>();
                visited.add(i);
                visited.add(neighborNode);

                while (!q.isEmpty()) {
                    int[] curr = q.poll();
                    int node = curr[0];
                    int dist = curr[1];

                    if (dist % signalSpeed == 0) {
                        distances.add(dist / signalSpeed);
                    }

                    for (int[] nextNeighbor : adj.get(node)) {
                        int nextNode = nextNeighbor[0];
                        int nextWeight = nextNeighbor[1];
                        if (!visited.contains(nextNode)) {
                            visited.add(nextNode);
                            q.offer(new int[]{nextNode, dist + nextWeight});
                        }
                    }
                }
            }

            int count = 0;
            for (int j = 0; j < distances.size(); j++) {
                for (int k = j + 1; k < distances.size(); k++) {
                    if (distances.get(j) + distances.get(k) == 10) {
                        count++;
                    }
                }
            }
            result[i] = count;
        }

        return result;
    }
}