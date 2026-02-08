import java.util.*;

class Solution {
    public int[] countPairs(int n, int[][] edges, int[] queries) {
        int[] degree = new int[n + 1];
        Map<Integer, Integer> common = new HashMap<>();
        for (int[] edge : edges) {
            int u = Math.min(edge[0], edge[1]);
            int v = Math.max(edge[0], edge[1]);
            degree[edge[0]]++;
            degree[edge[1]]++;
            int key = u * (n + 1) + v;
            common.put(key, common.getOrDefault(key, 0) + 1);
        }

        int[] sortedDegree = Arrays.copyOfRange(degree, 1, n + 1);
        Arrays.sort(sortedDegree);

        int[] result = new int[queries.length];
        for (int i = 0; i < queries.length; i++) {
            int count = 0;
            for (int j = 1; j <= n; j++) {
                int left = j + 1;
                int right = n;
                while (left <= right) {
                    int mid = left + (right - left) / 2;
                    if (sortedDegree[j - 1] + sortedDegree[mid - 1] > queries[i]) {
                        right = mid - 1;
                    } else {
                        left = mid + 1;
                    }
                }
                count += (n - j) - (left - j - 1);
            }

            for (Map.Entry<Integer, Integer> entry : common.entrySet()) {
                int key = entry.getKey();
                int u = key / (n + 1);
                int v = key % (n + 1);
                if (degree[u] + degree[v] > queries[i] && degree[u] + degree[v] - entry.getValue() <= queries[i]) {
                    count--;
                }
            }
            result[i] = count;
        }
        return result;
    }
}