public class Solution {

import java.util.*;

public class Solution {
    public int maximumScore(List<List<Integer>> adjacent, int[] nodes) {
        int n = nodes.length;
        if (n < 3) return -1;

        int maxScore = -1;
        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                if (i != j && adjacent.get(nodes[i]).contains(nodes[j])) {
                    for (int k = 0; k < n; k++) {
                        if (k != i && k != j && adjacent.get(nodes[j]).contains(nodes[k])) {
                            maxScore = Math.max(maxScore, nodes[i] + nodes[j] + nodes[k]);
                        }
                    }
                }
            }
        }
        return maxScore;
    }
}
}