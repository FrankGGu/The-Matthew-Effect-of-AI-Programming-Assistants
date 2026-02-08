import java.util.*;

class Solution {

    static class TreeInfo {
        int diameter;
        int radius;

        TreeInfo(int diameter, int radius) {
            this.diameter = diameter;
            this.radius = radius;
        }
    }

    public int findMinimumDiameterAfterMerge(int n1, int[][] edges1, int n2, int[][] edges2) {
        TreeInfo info1 = calculateTreeInfo(n1, edges1);
        TreeInfo info2 = calculateTreeInfo(n2, edges2);

        int diameter1 = info1.diameter;
        int diameter2 = info2.diameter;
        int mergedPath = info1.radius + 1 + info2.radius;

        return Math.max(Math.max(diameter1, diameter2), mergedPath);
    }

    private TreeInfo calculateTreeInfo(int n, int[][] edges) {
        if (n == 0) {
            return new TreeInfo(0, 0); 
        }
        if (n == 1) {
            return new TreeInfo(0, 0);
        }

        List<List<Integer>> adj = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            adj.add(new ArrayList<>());
        }
        for (int[] edge : edges) {
            adj.get(edge[0]).add(edge[1]);
            adj.get(edge[1]).add(edge[0]);
        }

        int[] downHeight = new int[n];
        int[] diameter = new int[1]; 

        dfs1_downHeight_and_diameter(0, -1, adj, downHeight, diameter);

        int[] upHeight = new int[n];
        dfs2_upHeight(0, -1, adj, downHeight, upHeight);

        int minEccentricity = Integer.MAX_VALUE;
        for (int i = 0; i < n; i++) {
            minEccentricity = Math.min(minEccentricity, Math.max(downHeight[i], upHeight[i]));
        }

        return new TreeInfo(diameter[0], minEccentricity);
    }

    private int dfs1_downHeight_and_diameter(int u, int p, List<List<Integer>> adj, int[] downHeight, int[] diameter) {
        int max1_child_h = -1; 
        int max2_child_h = -1; 

        for (int v : adj.get(u)) {
            if (v == p) continue;
            int child_h = dfs1_downHeight_and_diameter(v, u, adj, downHeight, diameter);
            if (child_h > max1_child_h) {
                max2_child_h = max1_child_h;
                max1_child_h = child_h;
            } else if (child_h > max2_child_h) {
                max2_child_h = child_h;
            }
        }

        downHeight[u] = (max1_child_h == -1) ? 0 : 1 + max1_child_h;

        int current_diameter_through_u = 0;
        if (max1_child_h != -1) {
            current_diameter_through_u += (1 + max1_child_h);
        }
        if (max2_child_h != -1) {
            current_diameter_through_u += (1 + max2_child_h);
        }
        diameter[0] = Math.max(diameter[0], current_diameter_through_u);

        return downHeight[u];
    }

    private void dfs2_upHeight(int u, int p, List<List<Integer>> adj, int[] downHeight, int[] upHeight) {
        int max1_child_h_val = -1; 
        int max2_child_h_val = -1; 

        for (int v : adj.get(u)) {
            if (v == p) continue;
            if (downHeight[v] > max1_child_h_val) {
                max2_child_h_val = max1_child_h_val;
                max1_child_h_val = downHeight[v];
            } else if (downHeight[v] > max2_child_h_val) {
                max2_child_h_val = downHeight[v];
            }
        }

        for (int v : adj.get(u)) {
            if (v == p) continue;

            int path_from_parent_through_u = 1 + upHeight[u];

            int path_from_sibling_through_u = -1;
            if (downHeight[v] == max1_child_h_val) { 
                if (max2_child_h_val != -1) {
                    path_from_sibling_through_u = 1 + max2_child_h_val;
                }
            } else { 
                if (max1_child_h_val != -1) {
                    path_from_sibling_through_u = 1 + max1_child_h_val;
                }
            }

            upHeight[v] = Math.max(path_from_parent_through_u, path_from_sibling_through_u);
            if (upHeight[v] == -1) { // This case should ideally not be reached for N >= 2 as path_from_parent_through_u will be at least 1
                upHeight[v] = 0;
            }

            dfs2_upHeight(v, u, adj, downHeight, upHeight);
        }
    }
}