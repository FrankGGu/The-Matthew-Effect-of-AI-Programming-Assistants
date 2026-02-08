class Solution {
    public int countIncremovableSubarrays(int[] arr) {
        int n = arr.length;
        int left = 0, right = n - 1;

        while (left + 1 < n && arr[left] <= arr[left + 1]) {
            left++;
        }
        while (right - 1 >= 0 && arr[right - 1] <= arr[right]) {
            right--;
        }
        if (left >= right) return n;

        int max = Math.max(arr[left], arr[right]);
        int min = Math.min(arr[left], arr[right]);

        while (left >= 0 && arr[left] > min) {
            left--;
        }
        while (right < n && arr[right] < max) {
            right++;
        }

        return right - left - 1;
    }
}