class Solution {
    public int smallestRangeII(int[] A, int K) {
        Arrays.sort(A);
        int n = A.length;
        int initialRange = A[n - 1] - A[0];
        int min = A[0] + K;
        int max = A[n - 1] - K;
        int result = initialRange;

        for (int i = 0; i < n - 1; i++) {
            int low = Math.min(min, A[i + 1] - K);
            int high = Math.max(max, A[i] + K);
            result = Math.min(result, high - low);
        }

        return result;
    }
}