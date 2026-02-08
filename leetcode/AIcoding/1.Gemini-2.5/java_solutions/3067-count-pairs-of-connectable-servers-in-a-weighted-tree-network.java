import java.util.ArrayList;
import java.util.List;

class Solution {
    public int[] countPairsOfConnectableServers(int[][] edges, int signalSpeed) {
        int n = edges.length + 1;
        List<List<int[]>> adj = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            adj.add(new ArrayList<>());
        }

        for (int[] edge : edges) {
            int u = edge[0];
            int v = edge[1];
            int weight = edge[2];
            adj.get(u).add(new int[]{v, weight});
            adj.get(v).add(new int[]{u, weight});
        }

        int[] ans = new int[n];

        for (int i = 0; i < n; i++) {
            int[] pathCountsMod = new int[signalSpeed]; // Stores counts of path lengths modulo signalSpeed from node i to nodes in branches already processed.
            int totalPairsFor_i = 0;

            for (int[] neighborEdge : adj.get(i)) {
                int neighbor = neighborEdge[0];
                int weight = neighborEdge[1];

                List<Integer> currentBranchDistances = new ArrayList<>();
                dfsCollectDistances(neighbor, i, weight, currentBranchDistances, adj);

                // For each node u in the current branch, find if it can form a connectable pair
                // with any node v from previously processed branches.
                for (int dist_u : currentBranchDistances) {
                    int rem_u = dist_u % signalSpeed;
                    int target_rem_v = (signalSpeed - rem_u) % signalSpeed;
                    totalPairsFor_i += pathCountsMod[target_rem_v];
                }

                // After processing the current branch, add its path length counts to pathCountsMod
                for (int dist_u : currentBranchDistances) {
                    pathCountsMod[dist_u % signalSpeed]++;
                }
            }
            ans[i] = totalPairsFor_i;
        }

        return ans;
    }

    private void dfsCollectDistances(int curr, int parent, int currentDistFromRoot, List<Integer> distances, List<List<int[]>> adj) {
        distances.add(currentDistFromRoot);

        for (int[] neighborEdge : adj.get(curr)) {
            int neighbor = neighborEdge[0];
            int weight = neighborEdge[1];
            if (neighbor != parent) {
                dfsCollectDistances(neighbor, curr, currentDistFromRoot + weight, distances, adj);
            }
        }
    }
}