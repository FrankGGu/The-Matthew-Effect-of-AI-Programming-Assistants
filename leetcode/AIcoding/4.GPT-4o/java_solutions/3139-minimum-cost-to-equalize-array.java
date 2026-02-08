import java.util.Arrays;

public class Solution {
    public long minCost(int[] A) {
        Arrays.sort(A);
        long total = 0;
        long median = A[A.length / 2];
        for (int num : A) {
            total += Math.abs(num - median);
        }
        return total;
    }
}