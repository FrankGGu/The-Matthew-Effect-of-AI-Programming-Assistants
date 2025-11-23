class Solution {
    public int[] addEdges(int n, int[][] edges) {
        int[] degree = new int[n + 1];
        for (int[] edge : edges) {
            degree[edge[0]]++;
            degree[edge[1]]++;
        }

        List<Integer> oddNodes = new ArrayList<>();
        for (int i = 1; i <= n; i++) {
            if (degree[i] % 2 != 0) {
                oddNodes.add(i);
            }
        }

        int m = oddNodes.size();
        int numEdgesToAdd = m / 2;
        int[] result = new int[numEdgesToAdd * 2];

        for (int i = 0; i < numEdgesToAdd; i++) {
            result[i * 2] = oddNodes.get(i * 2);
            result[i * 2 + 1] = oddNodes.get(i * 2 + 1);
        }

        return result;
    }
}