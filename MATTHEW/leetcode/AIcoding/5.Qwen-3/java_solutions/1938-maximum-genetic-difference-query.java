public class Solution {

import java.util.*;

public class Solution {
    public int[] queryIndices(int[] parents, int[] queries) {
        Map<Integer, List<int[]>> graph = new HashMap<>();
        for (int i = 0; i < parents.length; i++) {
            if (parents[i] != -1) {
                graph.computeIfAbsent(parents[i], k -> new ArrayList<>()).add(new int[]{i, i});
            }
        }

        int n = parents.length;
        int[] result = new int[queries.length];
        Arrays.fill(result, -1);

        int[] time = new int[n];
        int[] inTime = new int[n];
        int[] outTime = new int[n];
        int[] value = new int[n];
        int[] max = new int[n];
        int[] min = new int[n];
        int[] ans = new int[queries.length];

        int[] index = new int[queries.length];
        for (int i = 0; i < queries.length; i++) {
            index[i] = i;
        }

        Arrays.sort(index, (a, b) -> queries[a] - queries[b]);

        int[] bit = new int[2 * n + 2];
        int[] bitMax = new int[2 * n + 2];
        int[] bitMin = new int[2 * n + 2];

        int[] temp = new int[n];
        int[] tempMax = new int[n];
        int[] tempMin = new int[n];

        int[] visited = new int[n];
        int t = 0;

        dfs(0, graph, parents, time, inTime, outTime, value, visited, t);

        for (int i = 0; i < n; i++) {
            temp[inTime[i]] = value[i];
            tempMax[inTime[i]] = value[i];
            tempMin[inTime[i]] = value[i];
        }

        for (int i = 0; i < n; i++) {
            updateBit(bit, inTime[i] + 1, temp[i]);
            updateBitMax(bitMax, inTime[i] + 1, tempMax[i]);
            updateBitMin(bitMin, inTime[i] + 1, tempMin[i]);
        }

        for (int i = 0; i < queries.length; i++) {
            int q = queries[index[i]];
            int node = index[i];
            int l = inTime[node];
            int r = outTime[node];
            int maxVal = getBitMax(bitMax, r + 1) - getBitMax(bitMax, l);
            int minVal = getBitMin(bitMin, r + 1) - getBitMin(bitMin, l);
            ans[index[i]] = maxVal - minVal;
        }

        return ans;
    }

    private void dfs(int node, Map<Integer, List<int[]>> graph, int[] parents, int[] time, int[] inTime, int[] outTime, int[] value, int[] visited, int t) {
        if (visited[node] == 1) return;
        visited[node] = 1;
        inTime[node] = t++;
        value[node] = node;
        for (int[] child : graph.getOrDefault(node, new ArrayList<>())) {
            dfs(child[0], graph, parents, time, inTime, outTime, value, visited, t);
        }
        outTime[node] = t - 1;
    }

    private void updateBit(int[] bit, int idx, int val) {
        while (idx < bit.length) {
            bit[idx] += val;
            idx += idx & -idx;
        }
    }

    private void updateBitMax(int[] bit, int idx, int val) {
        while (idx < bit.length) {
            bit[idx] = Math.max(bit[idx], val);
            idx += idx & -idx;
        }
    }

    private void updateBitMin(int[] bit, int idx, int val) {
        while (idx < bit.length) {
            bit[idx] = Math.min(bit[idx], val);
            idx += idx & -idx;
        }
    }

    private int getBitMax(int[] bit, int idx) {
        int res = Integer.MIN_VALUE;
        while (idx > 0) {
            res = Math.max(res, bit[idx]);
            idx -= idx & -idx;
        }
        return res;
    }

    private int getBitMin(int[] bit, int idx) {
        int res = Integer.MAX_VALUE;
        while (idx > 0) {
            res = Math.min(res, bit[idx]);
            idx -= idx & -idx;
        }
        return res;
    }
}
}