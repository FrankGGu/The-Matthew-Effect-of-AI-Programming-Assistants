class Solution {
    public int countRootNodes(int[][] edges) {
        Set<Integer> children = new HashSet<>();
        for (int[] edge : edges) {
            children.add(edge[1]);
        }
        int count = 0;
        for (int[] edge : edges) {
            if (!children.contains(edge[0])) {
                count++;
            }
        }
        return count;
    }
}