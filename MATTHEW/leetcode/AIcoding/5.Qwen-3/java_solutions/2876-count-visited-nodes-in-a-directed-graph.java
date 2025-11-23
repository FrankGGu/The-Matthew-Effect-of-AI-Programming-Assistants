public class Solution {

import java.util.*;

public class Solution {
    public List<Integer> countVisitedNodes(List<List<Integer>> head) {
        int n = head.size();
        boolean[] visited = new boolean[n];
        int[] result = new int[n];
        List<Integer> res = new ArrayList<>();

        for (int i = 0; i < n; i++) {
            if (!visited[i]) {
                Map<Integer, Integer> map = new HashMap<>();
                List<Integer> path = new ArrayList<>();
                int node = i;
                while (!visited[node]) {
                    visited[node] = true;
                    path.add(node);
                    map.put(node, path.size() - 1);
                    node = head.get(node).get(0);
                }

                for (int j = 0; j < path.size(); j++) {
                    int idx = path.get(j);
                    if (map.containsKey(node)) {
                        int cycleLength = path.size() - map.get(node);
                        result[idx] = cycleLength + (j - map.get(node));
                    } else {
                        result[idx] = 1 + result[node];
                    }
                }
            }
        }

        for (int i : result) {
            res.add(i);
        }

        return res;
    }
}
}