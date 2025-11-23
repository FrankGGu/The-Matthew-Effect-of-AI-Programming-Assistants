import java.util.Arrays;

public class Solution {
    public int maxVolunteerAssignments(int[] A, int[] B) {
        Arrays.sort(A);
        Arrays.sort(B);
        int count = 0;
        int j = 0;
        for (int i = 0; i < A.length; i++) {
            while (j < B.length && B[j] < A[i]) {
                j++;
            }
            if (j < B.length) {
                count++;
                j++;
            }
        }
        return count;
    }
}