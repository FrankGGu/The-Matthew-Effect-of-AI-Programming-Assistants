class Solution {
    public int[][] outerTrees(int[][] trees) {
        if (trees.length <= 1) {
            return trees;
        }
        Arrays.sort(trees, (a, b) -> a[0] == b[0] ? a[1] - b[1] : a[0] - b[0]);
        List<int[]> hull = new ArrayList<>();
        for (int[] tree : trees) {
            while (hull.size() >= 2 && cross(hull.get(hull.size() - 2), hull.get(hull.size() - 1), tree) > 0) {
                hull.remove(hull.size() - 1);
            }
            hull.add(tree);
        }
        hull.remove(hull.size() - 1);
        for (int i = trees.length - 1; i >= 0; i--) {
            while (hull.size() >= 2 && cross(hull.get(hull.size() - 2), hull.get(hull.size() - 1), trees[i]) > 0) {
                hull.remove(hull.size() - 1);
            }
            hull.add(trees[i]);
        }
        Set<int[]> set = new HashSet<>(hull);
        return set.toArray(new int[set.size()][]);
    }

    private int cross(int[] o, int[] a, int[] b) {
        return (a[0] - o[0]) * (b[1] - o[1]) - (a[1] - o[1]) * (b[0] - o[0]);
    }
}