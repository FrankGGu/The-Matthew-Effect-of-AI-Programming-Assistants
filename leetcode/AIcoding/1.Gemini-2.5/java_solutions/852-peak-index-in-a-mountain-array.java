class Solution {
    public int peakIndexInMountainArray(int[] arr) {
        int low = 0;
        int high = arr.length - 1;

        while (low < high) {
            int mid = low + (high - low) / 2;
            if (arr[mid] < arr[mid + 1]) {
                // We are on the increasing slope, peak is to the right
                low = mid + 1;
            } else {
                // We are on the decreasing slope or at the peak
                // Peak could be mid or to the left
                high = mid;
            }
        }
        // When low == high, we have found the peak index
        return low;
    }
}