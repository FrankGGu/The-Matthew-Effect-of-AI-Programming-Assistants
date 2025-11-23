public class Solution {

import java.util.*;

public class Solution {
    public int[] getLeastNumOfVertices(int n, List<List<Integer>> edges) {
        boolean[] inDegree = new boolean[n];
        for (List<Integer> edge : edges) {
            inDegree[edge.get(1)] = true;
        }
        List<Integer> result = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            if (!inDegree[i]) {
                result.add(i);
            }
        }
        int[] res = new int[result.size()];
        for (int i = 0; i < res.length; i++) {
            res[i] = result.get(i);
        }
        return res;
    }
}
}