class Solution {
    public int peakIndexInMountainArray(int[] arr) {
        int left = 0;
        int right = arr.length - 1;

        while (left < right) {
            int mid = left + (right - left) / 2;
            if (arr[mid] < arr[mid + 1]) {
                // We are on the ascending slope, peak is to the right
                left = mid + 1;
            } else {
                // We are on the descending slope or at the peak
                // The peak could be mid, or to its left
                right = mid;
            }
        }
        // When left == right, we have found the peak index
        return left;
    }
}