class Solution {
    public int findMinDiameter(int[] tree1, int[] tree2) {
        int n = tree1.length;
        int[] degree = new int[n];
        List<List<Integer>> adj = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            adj.add(new ArrayList<>());
        }
        for (int i = 0; i < n; i++) {
            if (tree1[i] != -1) {
                adj.get(i).add(tree1[i]);
                adj.get(tree1[i]).add(i);
                degree[i]++;
                degree[tree1[i]]++;
            }
            if (tree2[i] != -1) {
                adj.get(i).add(tree2[i]);
                adj.get(tree2[i]).add(i);
                degree[i]++;
                degree[tree2[i]]++;
            }
        }
        Queue<Integer> leaves = new LinkedList<>();
        for (int i = 0; i < n; i++) {
            if (degree[i] == 1) {
                leaves.offer(i);
            }
        }
        int layers = 0;
        int remainingNodes = n;
        while (remainingNodes > 2) {
            int size = leaves.size();
            remainingNodes -= size;
            for (int i = 0; i < size; i++) {
                int leaf = leaves.poll();
                for (int neighbor : adj.get(leaf)) {
                    if (--degree[neighbor] == 1) {
                        leaves.offer(neighbor);
                    }
                }
            }
            layers++;
        }
        if (remainingNodes == 1) {
            return 2 * layers;
        } else {
            return 2 * layers + 1;
        }
    }
}