class Solution {
    public int[][] sortTheStudents(int[][] score, int k) {
        int n = score.length;
        Integer[] indices = new Integer[n];
        for (int i = 0; i < n; i++) {
            indices[i] = i;
        }

        Arrays.sort(indices, (a, b) -> score[b][k] - score[a][k]);

        int[][] result = new int[n][score[0].length];
        for (int i = 0; i < n; i++) {
            result[i] = score[indices[i]];
        }

        return result;
    }
}