public class Solution {

import java.util.*;

public class Solution {
    public int[] flipgame(int[][] pairs) {
        Set<Integer> seen = new HashSet<>();
        Set<Integer> result = new HashSet<>();
        Map<Integer, Set<Integer>> graph = new HashMap<>();

        for (int[] pair : pairs) {
            int a = pair[0];
            int b = pair[1];
            seen.add(a);
            seen.add(b);
            graph.putIfAbsent(a, new HashSet<>());
            graph.get(a).add(b);
            graph.putIfAbsent(b, new HashSet<>());
            graph.get(b).add(a);
        }

        for (int num : seen) {
            if (graph.get(num).size() == 1) {
                result.add(num);
            }
        }

        int[] res = new int[result.size()];
        int i = 0;
        for (int num : result) {
            res[i++] = num;
        }
        Arrays.sort(res);
        return res;
    }
}
}