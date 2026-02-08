class Solution {
    public int numberOfArithmeticSlices(int[] A) {
        int n = A.length;
        if (n < 3) return 0;
        int count = 0, current = 0;

        for (int i = 2; i < n; i++) {
            if (A[i] - A[i - 1] == A[i - 1] - A[i - 2]) {
                current++;
                count += current;
            } else {
                current = 0;
            }
        }

        return count;
    }
}