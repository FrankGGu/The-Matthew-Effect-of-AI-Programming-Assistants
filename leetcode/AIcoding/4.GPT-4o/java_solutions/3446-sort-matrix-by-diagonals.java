class Solution {
    public int[][] diagonalSort(int[][] mat) {
        int m = mat.length, n = mat[0].length;
        Map<Integer, List<Integer>> diagonals = new HashMap<>();

        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                diagonals.computeIfAbsent(i - j, x -> new ArrayList<>()).add(mat[i][j]);
            }
        }

        for (List<Integer> diagonal : diagonals.values()) {
            Collections.sort(diagonal);
        }

        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                mat[i][j] = diagonals.get(i - j).remove(0);
            }
        }

        return mat;
    }
}