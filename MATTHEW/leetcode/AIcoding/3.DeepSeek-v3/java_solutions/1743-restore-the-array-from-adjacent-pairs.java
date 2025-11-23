class Solution {
    public int[] restoreArray(int[][] adjacentPairs) {
        Map<Integer, List<Integer>> graph = new HashMap<>();
        for (int[] pair : adjacentPairs) {
            int u = pair[0], v = pair[1];
            graph.computeIfAbsent(u, k -> new ArrayList<>()).add(v);
            graph.computeIfAbsent(v, k -> new ArrayList<>()).add(u);
        }

        int root = 0;
        for (int key : graph.keySet()) {
            if (graph.get(key).size() == 1) {
                root = key;
                break;
            }
        }

        int[] result = new int[adjacentPairs.length + 1];
        result[0] = root;
        result[1] = graph.get(root).get(0);

        for (int i = 2; i < result.length; i++) {
            List<Integer> adj = graph.get(result[i - 1]);
            result[i] = adj.get(0) == result[i - 2] ? adj.get(1) : adj.get(0);
        }

        return result;
    }
}