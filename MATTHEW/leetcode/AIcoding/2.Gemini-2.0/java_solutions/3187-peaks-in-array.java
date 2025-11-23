class Solution {
    public int findPeaks(int[] mountain) {
        int left = 1, right = mountain.length - 2;
        while (left < right) {
            int mid = left + (right - left) / 2;
            if (mountain[mid] > mountain[mid + 1]) {
                right = mid;
            } else {
                left = mid + 1;
            }
        }
        return left;
    }
}