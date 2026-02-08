public class Solution {
    public int numSubarray boundedMaximum(int[] A, int left, int right) {
        int count = 0;
        int n = A.length;
        int last = -1;
        int prev = -1;

        for (int i = 0; i < n; i++) {
            if (A[i] >= left && A[i] <= right) {
                prev = i;
            } else if (A[i] > right) {
                last = i;
                prev = -1;
            }

            if (prev != -1) {
                count += prev - last;
            }
        }

        return count;
    }
}