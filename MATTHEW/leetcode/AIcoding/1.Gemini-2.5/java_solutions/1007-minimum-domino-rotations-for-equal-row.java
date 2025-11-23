class Solution {
    public int minDominoRotations(int[] A, int[] B) {
        int n = A.length;

        int rotations1 = check(A[0], A, B, n);
        int rotations2 = check(B[0], A, B, n);

        if (rotations1 == -1 && rotations2 == -1) {
            return -1;
        } else if (rotations1 == -1) {
            return rotations2;
        } else if (rotations2 == -1) {
            return rotations1;
        } else {
            return Math.min(rotations1, rotations2);
        }
    }

    private int check(int x, int[] A, int[] B, int n) {
        int rotationsA = 0; // Number of rotations to make A all x
        int rotationsB = 0; // Number of rotations to make B all x

        for (int i = 0; i < n; i++) {
            if (A[i] != x && B[i] != x) {
                return -1; // Impossible to make either row all x at this position
            } else if (A[i] != x) {
                // A[i] is not x, but B[i] is x. Rotate to make A[i] become x.
                rotationsA++;
            } else if (B[i] != x) {
                // B[i] is not x, but A[i] is x. Rotate to make B[i] become x.
                rotationsB++;
            }
            // If both A[i] == x and B[i] == x, no rotation needed for either count.
        }

        return Math.min(rotationsA, rotationsB);
    }
}