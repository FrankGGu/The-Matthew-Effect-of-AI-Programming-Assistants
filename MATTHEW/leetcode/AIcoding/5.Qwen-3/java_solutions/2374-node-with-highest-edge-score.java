public class Solution {

import java.util.*;

public class Solution {
    public int mostVisitedNode(int[] edges) {
        int n = edges.length;
        int[] edgeScore = new int[n];
        Arrays.fill(edgeScore, 0);

        for (int i = 0; i < n; i++) {
            if (edges[i] != -1) {
                edgeScore[edges[i]]++;
            }
        }

        int maxScore = -1;
        int result = 0;
        for (int i = 0; i < n; i++) {
            if (edgeScore[i] > maxScore) {
                maxScore = edgeScore[i];
                result = i;
            } else if (edgeScore[i] == maxScore && i < result) {
                result = i;
            }
        }

        return result;
    }
}
}