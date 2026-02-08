import java.util.Arrays;

public class Solution {
    private int count = 0;

    public int numSquarefulPerms(int[] A) {
        Arrays.sort(A);
        boolean[] used = new boolean[A.length];
        backtrack(A, used, 0, -1);
        return count;
    }

    private void backtrack(int[] A, boolean[] used, int length, int prev) {
        if (length == A.length) {
            count++;
            return;
        }
        for (int i = 0; i < A.length; i++) {
            if (used[i] || (i > 0 && A[i] == A[i - 1] && !used[i - 1])) {
                continue;
            }
            if (prev == -1 || isSquareful(prev, A[i])) {
                used[i] = true;
                backtrack(A, used, length + 1, A[i]);
                used[i] = false;
            }
        }
    }

    private boolean isSquareful(int a, int b) {
        int sum = a + b;
        int sqrt = (int) Math.sqrt(sum);
        return sqrt * sqrt == sum;
    }
}