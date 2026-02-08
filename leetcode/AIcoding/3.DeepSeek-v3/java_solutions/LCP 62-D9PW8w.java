class Solution {
    public int transportationHub(int[][] path) {
        Map<Integer, Set<Integer>> inDegree = new HashMap<>();
        Map<Integer, Set<Integer>> outDegree = new HashMap<>();
        Set<Integer> nodes = new HashSet<>();

        for (int[] p : path) {
            int from = p[0];
            int to = p[1];
            nodes.add(from);
            nodes.add(to);

            outDegree.computeIfAbsent(from, k -> new HashSet<>()).add(to);
            inDegree.computeIfAbsent(to, k -> new HashSet<>()).add(from);
        }

        for (int node : nodes) {
            if (!outDegree.containsKey(node) || outDegree.get(node).isEmpty()) {
                if (inDegree.containsKey(node) && inDegree.get(node).size() == nodes.size() - 1) {
                    return node;
                }
            }
        }

        return -1;
    }
}