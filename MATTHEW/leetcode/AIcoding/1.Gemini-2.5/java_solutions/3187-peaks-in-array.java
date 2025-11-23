class Solution {
    public int longestPeak(int[] arr) {
        int n = arr.length;
        if (n < 3) {
            return 0;
        }

        int maxLength = 0;
        int i = 1; 

        while (i < n - 1) {
            boolean isPeak = arr[i - 1] < arr[i] && arr[i] > arr[i + 1];

            if (!isPeak) {
                i++;
                continue;
            }

            int leftIdx = i - 2;
            while (leftIdx >= 0 && arr[leftIdx] < arr[leftIdx + 1]) {
                leftIdx--;
            }

            int rightIdx = i + 2;
            while (rightIdx < n && arr[rightIdx] < arr[rightIdx - 1]) {
                rightIdx++;
            }

            maxLength = Math.max(maxLength, rightIdx - leftIdx - 1);

            i = rightIdx - 1;
        }

        return maxLength;
    }
}