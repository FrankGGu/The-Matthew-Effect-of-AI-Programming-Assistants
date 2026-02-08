class Solution {
    public int longestMountain(int[] arr) {
        int n = arr.length;
        if (n < 3) {
            return 0;
        }

        int maxLen = 0;
        int base = 0;

        while (base < n) {
            int i = base;

            // Find uphill slope
            // arr[i] < arr[i+1]
            while (i + 1 < n && arr[i] < arr[i+1]) {
                i++;
            }

            // Check if we found a peak (i.e., i moved from base, and there's potential for downhill)
            // A mountain must have an uphill part (i > base) and a downhill part (i < n - 1)
            if (i == base || i == n - 1) {
                base++; // No uphill or no space for downhill, move to the next potential base
                continue;
            }

            // Find downhill slope
            // arr[i] > arr[i+1]
            int peak = i;
            while (i + 1 < n && arr[i] > arr[i+1]) {
                i++;
            }

            // If we found a downhill slope (i.e., i moved from peak)
            if (i > peak) {
                maxLen = Math.max(maxLen, i - base + 1);
            }

            // Move base to the current 'i'. This is important because arr[i] might be the start
            // of a new mountain or a part of a plateau.
            // If arr[i] was part of a downhill slope, the next potential mountain could start from arr[i].
            // If arr[i] was part of a plateau (e.g., [1,2,2,3,1]), the next mountain could start after the plateau.
            // The `base++` in the `if (i == base || i == n - 1)` block handles the case where `i` didn't move.
            base = i; 
        }

        return maxLen;
    }
}