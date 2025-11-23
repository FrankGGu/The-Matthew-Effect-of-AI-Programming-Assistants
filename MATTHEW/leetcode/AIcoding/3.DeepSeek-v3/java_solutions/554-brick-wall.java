class Solution {
    public int leastBricks(List<List<Integer>> wall) {
        Map<Integer, Integer> edgeCount = new HashMap<>();
        int maxEdges = 0;

        for (List<Integer> row : wall) {
            int edgePosition = 0;
            for (int i = 0; i < row.size() - 1; i++) {
                edgePosition += row.get(i);
                edgeCount.put(edgePosition, edgeCount.getOrDefault(edgePosition, 0) + 1);
                maxEdges = Math.max(maxEdges, edgeCount.get(edgePosition));
            }
        }

        return wall.size() - maxEdges;
    }
}