import java.util.Arrays;

class Solution {
    public int[] longestObstacleCourseAtEachPosition(int[] obstacles) {
        int n = obstacles.length;
        int[] ans = new int[n];

        // tails[k] stores the smallest ending element of a non-decreasing subsequence of length k+1.
        // The 'tails' array itself will always be in non-decreasing order.
        int[] tails = new int[n];
        int len = 0; // Current length of the longest non-decreasing subsequence found so far

        for (int i = 0; i < n; i++) {
            int obstacle = obstacles[i];

            // Find the insertion point for 'obstacle' in the 'tails' array.
            // We are looking for the index 'idx' such that tails[idx-1] <= obstacle <= tails[idx].
            // If obstacle is already present, Arrays.binarySearch returns its index.
            // If not found, it returns `(-(insertion_point) - 1)`.
            // The insertion_point is the index where the element would be inserted to maintain sorted order,
            // which is the index of the first element greater than or equal to 'obstacle'.
            int idx = Arrays.binarySearch(tails, 0, len, obstacle);

            if (idx < 0) {
                // Element not found, calculate the actual insertion point.
                // This is the index of the first element strictly greater than 'obstacle'.
                idx = -(idx + 1);
            }

            // Place 'obstacle' at the found position.
            // This either replaces an existing element (if 'obstacle' is smaller or equal)
            // or extends the 'tails' array (if 'obstacle' is the largest so far).
            tails[idx] = obstacle;

            // If 'obstacle' was placed at the end of the current 'tails' (meaning it extended the LNDS),
            // increment the length of the LNDS.
            if (idx == len) {
                len++;
            }

            // The length of the longest non-decreasing subsequence ending at obstacles[i]
            // is (idx + 1) because 'idx' is 0-based.
            ans[i] = idx + 1;
        }

        return ans;
    }
}