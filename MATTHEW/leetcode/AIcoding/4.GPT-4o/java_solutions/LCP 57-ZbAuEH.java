public class Solution {
    public int[] digMole(int[] A, int[] B) {
        int n = A.length;
        int[] res = new int[n];
        for (int i = 0; i < n; i++) {
            res[i] = A[i] - B[i];
        }
        return res;
    }
}