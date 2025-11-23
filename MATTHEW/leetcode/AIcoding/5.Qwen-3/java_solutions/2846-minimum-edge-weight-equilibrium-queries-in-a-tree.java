public class Solution {

import java.util.*;

public class Solution {
    private List<List<int[]>> graph;
    private int[] parent;
    private int[] size;
    private int[] weight;

    public int[] findAnswer(int[] nums, int[][] edges) {
        int n = nums.length;
        graph = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            graph.add(new ArrayList<>());
        }
        for (int[] edge : edges) {
            int u = edge[0], v = edge[1];
            graph.get(u).add(new int[]{v, 1});
            graph.get(v).add(new int[]{u, 1});
        }

        parent = new int[n];
        size = new int[n];
        weight = new int[n];

        Arrays.fill(parent, -1);
        dfs(0, -1);

        int[] result = new int[n];
        for (int i = 0; i < n; i++) {
            result[i] = query(i);
        }
        return result;
    }

    private void dfs(int node, int p) {
        parent[node] = p;
        size[node] = 1;
        weight[node] = nums[node];
        for (int[] neighbor : graph.get(node)) {
            int next = neighbor[0];
            if (next != p) {
                dfs(next, node);
                size[node] += size[next];
                weight[node] += weight[next];
            }
        }
    }

    private int query(int node) {
        int totalWeight = weight[0];
        int leftWeight = 0;
        int rightWeight = 0;
        int leftSize = 0;
        int rightSize = 0;

        int current = node;
        while (current != -1) {
            int parentOfCurrent = parent[current];
            if (parentOfCurrent == -1) {
                break;
            }
            int sibling = -1;
            for (int[] neighbor : graph.get(parentOfCurrent)) {
                int next = neighbor[0];
                if (next != current && next != parentOfCurrent) {
                    sibling = next;
                    break;
                }
            }

            if (sibling != -1) {
                leftWeight = weight[sibling];
                leftSize = size[sibling];
            } else {
                leftWeight = 0;
                leftSize = 0;
            }

            rightWeight = totalWeight - weight[current];
            rightSize = totalWeight - size[current];

            if (leftWeight == rightWeight && leftSize == rightSize) {
                return 1;
            }

            current = parentOfCurrent;
        }

        return 0;
    }
}
}