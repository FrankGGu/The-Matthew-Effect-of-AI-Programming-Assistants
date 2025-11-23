class Solution {
    public int stoneGameVI(int[] A, int[] B) {
        int n = A.length;
        Integer[] indices = new Integer[n];
        for (int i = 0; i < n; i++) {
            indices[i] = i;
        }
        Arrays.sort(indices, (i, j) -> (B[j] + A[j]) - (B[i] + A[i]));

        int aliceScore = 0, bobScore = 0;
        for (int i = 0; i < n; i++) {
            if (i % 2 == 0) {
                aliceScore += A[indices[i]];
            } else {
                bobScore += B[indices[i]];
            }
        }

        return Integer.compare(aliceScore, bobScore);
    }
}