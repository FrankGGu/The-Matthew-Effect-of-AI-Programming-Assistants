import java.util.*;

public class Solution {
    public int[] modifyGraphEdges(int n, int[][] edges) {
        int[] result = new int[edges.length];
        boolean[] isEdgeUsed = new boolean[n];
        int index = 0;

        for (int[] edge : edges) {
            if (edge[0] != 0 && edge[1] != 0) {
                isEdgeUsed[edge[0]] = true;
                isEdgeUsed[edge[1]] = true;
            }
        }

        int availableWeight = 1;
        for (int i = 0; i < edges.length; i++) {
            if (edges[i][0] == 0 || edges[i][1] == 0) {
                while (isEdgeUsed[availableWeight]) {
                    availableWeight++;
                }
                result[i] = availableWeight++;
            } else {
                result[i] = -1;
            }
        }

        return result;
    }
}