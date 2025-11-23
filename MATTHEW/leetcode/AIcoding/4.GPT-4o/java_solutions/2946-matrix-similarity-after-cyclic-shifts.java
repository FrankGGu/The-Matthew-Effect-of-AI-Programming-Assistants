class Solution {
    public boolean areSimilar(int[][] A, int[][] B) {
        int n = A.length;
        int m = A[0].length;

        int[] countA = new int[101];
        int[] countB = new int[101];

        for (int i = 0; i < n; i++) {
            for (int j = 0; j < m; j++) {
                countA[A[i][j]]++;
                countB[B[i][j]]++;
            }
        }

        for (int i = 0; i < 101; i++) {
            if (countA[i] != countB[i]) {
                return false;
            }
        }

        for (int i = 0; i < n; i++) {
            int[] rowA = A[i];
            int[] rowB = B[i];
            if (!isCyclicShift(rowA, rowB)) {
                return false;
            }
        }

        return true;
    }

    private boolean isCyclicShift(int[] rowA, int[] rowB) {
        String strA = arrayToString(rowA);
        String strB = arrayToString(rowB);
        return (strA + strA).contains(strB);
    }

    private String arrayToString(int[] arr) {
        StringBuilder sb = new StringBuilder();
        for (int num : arr) {
            sb.append(num).append(",");
        }
        return sb.toString();
    }
}