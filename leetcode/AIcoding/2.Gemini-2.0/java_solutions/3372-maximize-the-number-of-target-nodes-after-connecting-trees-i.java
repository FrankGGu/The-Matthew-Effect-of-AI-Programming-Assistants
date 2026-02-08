import java.util.*;

class Solution {
    public int maximizeTheNumberOfTargetNodes(List<List<Integer>> edges) {
        Set<Integer> roots = new HashSet<>();
        Set<Integer> children = new HashSet<>();
        Map<Integer, Integer> parent = new HashMap<>();

        for (List<Integer> edge : edges) {
            int u = edge.get(0);
            int v = edge.get(1);
            children.add(v);
            parent.put(v, u);
        }

        for (List<Integer> edge : edges) {
            int u = edge.get(0);
            if (!children.contains(u)) {
                roots.add(u);
            }
        }

        List<Integer> rootList = new ArrayList<>(roots);
        Collections.sort(rootList);

        int count = 0;
        Set<Integer> used = new HashSet<>();

        for (int root : rootList) {
            if (used.contains(root)) continue;
            int curr = root;
            while (parent.containsKey(curr)) {
                curr = parent.get(curr);
                if (!used.contains(curr)) {
                    count++;
                    used.add(curr);
                    break;
                }
            }
        }

        return count;
    }
}