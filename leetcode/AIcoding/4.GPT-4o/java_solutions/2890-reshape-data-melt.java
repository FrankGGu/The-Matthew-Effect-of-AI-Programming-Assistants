class Solution {
    public List<List<Integer>> melt(int[][] mat) {
        List<List<Integer>> result = new ArrayList<>();
        int rows = mat.length;
        int cols = mat[0].length;

        for (int i = 0; i < rows; i++) {
            for (int j = 0; j < cols; j++) {
                result.add(Arrays.asList(mat[i][j], i, j));
            }
        }
        return result;
    }
}