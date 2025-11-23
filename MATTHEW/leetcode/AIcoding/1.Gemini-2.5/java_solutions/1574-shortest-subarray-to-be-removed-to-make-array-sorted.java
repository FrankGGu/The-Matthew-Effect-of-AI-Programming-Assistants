class Solution {
    public int findLengthOfShortestSubarray(int[] arr) {
        int n = arr.length;

        // Find the longest non-decreasing prefix
        int left = 0;
        while (left + 1 < n && arr[left] <= arr[left + 1]) {
            left++;
        }

        // If the entire array is sorted, no removal needed
        if (left == n - 1) {
            return 0;
        }

        // Find the longest non-decreasing suffix
        int right = n - 1;
        while (right - 1 >= 0 && arr[right - 1] <= arr[right]) {
            right--;
        }

        // Initialize the minimum length of subarray to remove
        // Case 1: Remove everything after 'left' (remaining is arr[0...left])
        // Case 2: Remove everything before 'right' (remaining is arr[right...n-1])
        int ans = Math.min(n - 1 - left, right);

        // Consider combining a prefix arr[0...p1] and a suffix arr[p2...n-1]
        // where arr[p1] <= arr[p2]
        int p1 = 0; // Pointer for the prefix part
        int p2 = right; // Pointer for the suffix part, starting from the beginning of the sorted suffix

        while (p1 <= left && p2 < n) {
            if (arr[p1] <= arr[p2]) {
                // Valid combination: arr[0...p1] and arr[p2...n-1]
                // Length of removed subarray is (p2 - 1) - (p1 + 1) + 1 = p2 - p1 - 1
                ans = Math.min(ans, p2 - p1 - 1);
                p1++; // Try to extend the prefix
            } else {
                p2++; // arr[p1] is too large, need a larger arr[p2]
            }
        }

        return ans;
    }
}