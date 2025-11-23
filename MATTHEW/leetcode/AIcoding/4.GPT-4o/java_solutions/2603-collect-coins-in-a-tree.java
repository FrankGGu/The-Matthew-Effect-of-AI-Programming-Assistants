class Solution {
    public int collectTheCoins(int[] coins, int[][] edges) {
        List<List<Integer>> graph = new ArrayList<>();
        for (int i = 0; i < coins.length; i++) {
            graph.add(new ArrayList<>());
        }
        for (int[] edge : edges) {
            graph.get(edge[0]).add(edge[1]);
            graph.get(edge[1]).add(edge[0]);
        }

        boolean[] visited = new boolean[coins.length];
        List<Integer> leaves = new ArrayList<>();
        for (int i = 0; i < coins.length; i++) {
            if (coins[i] == 1) {
                leaves.add(i);
            }
        }

        while (leaves.size() > 0) {
            List<Integer> newLeaves = new ArrayList<>();
            for (int leaf : leaves) {
                visited[leaf] = true;
                boolean isLeaf = true;
                for (int neighbor : graph.get(leaf)) {
                    if (!visited[neighbor]) {
                        isLeaf = false;
                        boolean hasCoin = coins[neighbor] == 1;
                        for (int n : graph.get(neighbor)) {
                            if (!visited[n]) {
                                hasCoin = true;
                                break;
                            }
                        }
                        if (!hasCoin) {
                            newLeaves.add(neighbor);
                        }
                    }
                }
                if (isLeaf) {
                    coins[leaf] = 0;
                }
            }
            leaves = newLeaves;
        }

        int totalEdges = edges.length;
        int totalCoins = 0;
        for (int coin : coins) {
            if (coin == 1) {
                totalCoins++;
            }
        }

        return totalCoins == 0 ? 0 : Math.max(0, totalEdges - totalCoins * 2);
    }
}