import java.util.Arrays;

class Solution {
    public int findClosestNode(int n, int[] edges, int node1, int node2) {
        int[] dist1 = new int[n];
        Arrays.fill(dist1, -1);

        int[] dist2 = new int[n];
        Arrays.fill(dist2, -1);

        int curr = node1;
        int d = 0;
        while (curr != -1 && dist1[curr] == -1) {
            dist1[curr] = d;
            curr = edges[curr];
            d++;
        }

        curr = node2;
        d = 0;
        while (curr != -1 && dist2[curr] == -1) {
            dist2[curr] = d;
            curr = edges[curr];
            d++;
        }

        int minMaxDist = Integer.MAX_VALUE;
        int resultNode = -1;

        for (int i = 0; i < n; i++) {
            if (dist1[i] != -1 && dist2[i] != -1) {
                int currentMaxDist = Math.max(dist1[i], dist2[i]);
                if (currentMaxDist < minMaxDist) {
                    minMaxDist = currentMaxDist;
                    resultNode = i;
                }
            }
        }

        return resultNode;
    }
}