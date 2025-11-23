class Solution {
    public int numSubarraysWithSum(int[] A, int S) {
        return atMost(A, S) - atMost(A, S - 1);
    }

    private int atMost(int[] A, int S) {
        if (S < 0) return 0;
        int count = 0, left = 0;
        for (int right = 0; right < A.length; right++) {
            S -= A[right];
            while (S < 0) {
                S += A[left++];
            }
            count += right - left + 1;
        }
        return count;
    }
}