import java.util.*;

class Solution {
    public List<Integer> findSmallestSetOfVertices(int n, List<List<Integer>> edges) {
        Set<Integer> reachable = new HashSet<>();
        for (List<Integer> edge : edges) {
            reachable.add(edge.get(1));
        }
        List<Integer> result = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            if (!reachable.contains(i)) {
                result.add(i);
            }
        }
        return result;
    }
}