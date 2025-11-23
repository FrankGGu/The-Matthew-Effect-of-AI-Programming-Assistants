class Solution {
    int[] count;
    List<List<Integer>> graph;

    public int[] countSubTrees(int n, int[][] edges, String labels) {
        count = new int[n];
        graph = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            graph.add(new ArrayList<>());
        }
        for (int[] edge : edges) {
            graph.get(edge[0]).add(edge[1]);
            graph.get(edge[1]).add(edge[0]);
        }
        dfs(0, -1, labels);
        return count;
    }

    private int[] dfs(int node, int parent, String labels) {
        int[] labelCount = new int[26];
        char label = labels.charAt(node);
        labelCount[label - 'a']++;

        for (int neighbor : graph.get(node)) {
            if (neighbor != parent) {
                int[] childCount = dfs(neighbor, node, labels);
                for (int i = 0; i < 26; i++) {
                    labelCount[i] += childCount[i];
                }
            }
        }

        count[node] = labelCount[label - 'a'];
        return labelCount;
    }
}