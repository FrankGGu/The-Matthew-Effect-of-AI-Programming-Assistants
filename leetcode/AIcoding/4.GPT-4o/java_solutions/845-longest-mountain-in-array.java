class Solution {
    public int longestMountain(int[] A) {
        int n = A.length;
        int maxLength = 0;

        for (int i = 1; i < n - 1; ) {
            if (A[i] > A[i - 1] && A[i] > A[i + 1]) {
                int left = i - 1;
                int right = i + 1;

                while (left > 0 && A[left] > A[left - 1]) {
                    left--;
                }
                while (right < n - 1 && A[right] > A[right + 1]) {
                    right++;
                }

                maxLength = Math.max(maxLength, right - left + 1);
                i = right; 
            } else {
                i++;
            }
        }

        return maxLength;
    }
}