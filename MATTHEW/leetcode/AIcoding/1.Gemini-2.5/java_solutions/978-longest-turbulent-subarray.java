class Solution {
    public int longestTurbulentSubarray(int[] arr) {
        int n = arr.length;
        if (n <= 1) {
            return n;
        }

        int maxLen = 1;
        int up = 1;   // Length of turbulent subarray ending with arr[i-1] < arr[i]
        int down = 1; // Length of turbulent subarray ending with arr[i-1] > arr[i]

        for (int i = 1; i < n; i++) {
            if (arr[i] > arr[i - 1]) {
                // Current segment is increasing: arr[i-1] < arr[i]
                // It can extend a 'down' sequence (arr[i-2] > arr[i-1] < arr[i])
                up = down + 1;
                down = 1; // Cannot end with a decreasing pair if current is increasing
            } else if (arr[i] < arr[i - 1]) {
                // Current segment is decreasing: arr[i-1] > arr[i]
                // It can extend an 'up' sequence (arr[i-2] < arr[i-1] > arr[i])
                down = up + 1;
                up = 1; // Cannot end with an increasing pair if current is decreasing
            } else {
                // arr[i] == arr[i-1], turbulence breaks
                up = 1;
                down = 1;
            }
            maxLen = Math.max(maxLen, Math.max(up, down));
        }

        return maxLen;
    }
}