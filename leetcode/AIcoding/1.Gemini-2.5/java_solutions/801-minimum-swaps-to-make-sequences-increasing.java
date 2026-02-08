class Solution {
    public int minSwap(int[] A, int[] B) {
        int n = A.length;

        int prevKeep = 0;
        int prevSwap = 1;

        for (int i = 1; i < n; i++) {
            int currKeep = Integer.MAX_VALUE;
            int currSwap = Integer.MAX_VALUE;

            // Calculate currKeep (A[i], B[i] are NOT swapped)
            // Path from prevKeep (A[i-1], B[i-1] were NOT swapped)
            if (A[i-1] < A[i] && B[i-1] < B[i]) {
                currKeep = prevKeep;
            }
            // Path from prevSwap (A[i-1], B[i-1] WERE swapped)
            if (B[i-1] < A[i] && A[i-1] < B[i]) {
                currKeep = Math.min(currKeep, prevSwap);
            }

            // Calculate currSwap (A[i], B[i] ARE swapped)
            // Path from prevKeep (A[i-1], B[i-1] were NOT swapped)
            if (A[i-1] < B[i] && B[i-1] < A[i]) {
                currSwap = prevKeep + 1;
            }
            // Path from prevSwap (A[i-1], B[i-1] WERE swapped)
            if (B[i-1] < B[i] && A[i-1] < A[i]) {
                currSwap = Math.min(currSwap, prevSwap + 1);
            }

            prevKeep = currKeep;
            prevSwap = currSwap;
        }

        return Math.min(prevKeep, prevSwap);
    }
}