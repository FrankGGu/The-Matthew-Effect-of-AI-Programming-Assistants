import java.util.Arrays;

public class Solution {
    public int minWastedSpace(int[] A, int[][] boxes) {
        Arrays.sort(A);
        int n = A.length;
        long total = 0;
        for (int a : A) total += a;

        long minWaste = Long.MAX_VALUE;
        for (int[] box : boxes) {
            Arrays.sort(box);
            if (box[box.length - 1] < A[n - 1]) continue;

            long waste = 0;
            int j = 0;
            for (int b : box) {
                int count = 0;
                while (j < n && A[j] <= b) {
                    waste += b - A[j];
                    count++;
                    j++;
                }
                if (count == 0) break;
            }
            minWaste = Math.min(minWaste, waste);
        }

        return minWaste == Long.MAX_VALUE ? -1 : (int) minWaste;
    }
}