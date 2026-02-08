class Solution {
    public boolean isMonotonic(int[] A) {
        if (A.length <= 1) return true;
        boolean increasing = true, decreasing = true;

        for (int i = 1; i < A.length; i++) {
            if (A[i] > A[i - 1]) decreasing = false;
            if (A[i] < A[i - 1]) increasing = false;
        }

        return increasing || decreasing;
    }
}