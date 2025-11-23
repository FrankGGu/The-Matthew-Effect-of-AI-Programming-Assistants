import java.util.Arrays;

class Solution {
    public int minOperations(int[] A, int[] B) {
        Arrays.sort(A);
        Arrays.sort(B);
        int n = A.length;
        int[] countA = new int[101], countB = new int[101];

        for (int num : A) countA[num]++;
        for (int num : B) countB[num]++;

        int operations = 0;
        for (int i = 0; i < 101; i++) {
            operations += Math.abs(countA[i] - countB[i]);
        }

        return operations / 2;
    }
}