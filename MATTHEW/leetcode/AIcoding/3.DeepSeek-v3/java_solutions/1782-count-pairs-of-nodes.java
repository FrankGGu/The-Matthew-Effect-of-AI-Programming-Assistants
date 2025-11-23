class Solution {
    public int[] countPairs(int n, int[][] edges, int[] queries) {
        int[] degree = new int[n + 1];
        Map<Integer, Integer> edgeCount = new HashMap<>();

        for (int[] edge : edges) {
            int u = Math.min(edge[0], edge[1]);
            int v = Math.max(edge[0], edge[1]);
            degree[u]++;
            degree[v]++;
            int key = u * (n + 1) + v;
            edgeCount.put(key, edgeCount.getOrDefault(key, 0) + 1);
        }

        int[] sortedDegree = degree.clone();
        Arrays.sort(sortedDegree);

        int[] res = new int[queries.length];
        for (int q = 0; q < queries.length; q++) {
            int query = queries[q];
            int total = 0;
            int left = 1, right = n;
            while (left < right) {
                if (sortedDegree[left] + sortedDegree[right] > query) {
                    total += right - left;
                    right--;
                } else {
                    left++;
                }
            }

            for (Map.Entry<Integer, Integer> entry : edgeCount.entrySet()) {
                int key = entry.getKey();
                int u = key / (n + 1);
                int v = key % (n + 1);
                int sum = degree[u] + degree[v];
                if (sum > query && sum - entry.getValue() <= query) {
                    total--;
                }
            }
            res[q] = total;
        }
        return res;
    }
}