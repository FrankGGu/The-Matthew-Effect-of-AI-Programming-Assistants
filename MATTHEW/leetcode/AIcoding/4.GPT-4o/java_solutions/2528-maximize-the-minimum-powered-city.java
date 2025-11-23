class Solution {
    public int maximizeMinCity(int[] A, int k) {
        int n = A.length;
        Arrays.sort(A);
        int left = 0, right = A[n - 1];

        while (left < right) {
            int mid = left + (right - left + 1) / 2;
            if (canAchieve(A, mid, k)) {
                left = mid;
            } else {
                right = mid - 1;
            }
        }
        return left;
    }

    private boolean canAchieve(int[] A, int min, int k) {
        int n = A.length, count = 0;
        for (int i = 0; i < n; i++) {
            if (A[i] < min) {
                count += min - A[i];
            }
            if (count > k) {
                return false;
            }
        }
        return count <= k;
    }
}