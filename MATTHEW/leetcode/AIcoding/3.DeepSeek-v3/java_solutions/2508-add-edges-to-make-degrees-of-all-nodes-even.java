class Solution {
    public boolean isPossible(int n, List<List<Integer>> edges) {
        Map<Integer, Set<Integer>> graph = new HashMap<>();
        for (int i = 1; i <= n; i++) {
            graph.put(i, new HashSet<>());
        }
        for (List<Integer> edge : edges) {
            int u = edge.get(0);
            int v = edge.get(1);
            graph.get(u).add(v);
            graph.get(v).add(u);
        }

        List<Integer> oddNodes = new ArrayList<>();
        for (int i = 1; i <= n; i++) {
            if (graph.get(i).size() % 2 != 0) {
                oddNodes.add(i);
            }
        }

        if (oddNodes.size() == 0) {
            return true;
        }
        if (oddNodes.size() == 2) {
            int a = oddNodes.get(0);
            int b = oddNodes.get(1);
            if (!graph.get(a).contains(b)) {
                return true;
            } else {
                for (int i = 1; i <= n; i++) {
                    if (i != a && i != b && !graph.get(i).contains(a) && !graph.get(i).contains(b)) {
                        return true;
                    }
                }
                return false;
            }
        }
        if (oddNodes.size() == 4) {
            int a = oddNodes.get(0);
            int b = oddNodes.get(1);
            int c = oddNodes.get(2);
            int d = oddNodes.get(3);
            if ((!graph.get(a).contains(b) && !graph.get(c).contains(d)) ||
                (!graph.get(a).contains(c) && !graph.get(b).contains(d)) ||
                (!graph.get(a).contains(d) && !graph.get(b).contains(c))) {
                return true;
            }
            return false;
        }
        return false;
    }
}