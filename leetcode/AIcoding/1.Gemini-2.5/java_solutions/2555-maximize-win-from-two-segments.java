import java.util.Arrays;

class Solution {
    public int maximizeWin(int[] positions, int k) {
        int n = positions.length;
        if (n == 0) {
            return 0;
        }

        // max_segment_ending_at_or_before[i] stores the maximum number of items
        // in a single segment of length at most k that ends at or before positions[i].
        int[] max_segment_ending_at_or_before = new int[n];
        int left = 0;
        int current_max_wins_prefix = 0;
        for (int i = 0; i < n; i++) {
            while (positions[i] - positions[left] > k) {
                left++;
            }
            current_max_wins_prefix = Math.max(current_max_wins_prefix, i - left + 1);
            max_segment_ending_at_or_before[i] = current_max_wins_prefix;
        }

        // max_segment_starting_at_or_after[i] stores the maximum number of items
        // in a single segment of length at most k that starts at or after positions[i].
        int[] max_segment_starting_at_or_after = new int[n];
        int right = n - 1;
        int current_max_wins_suffix = 0;
        for (int i = n - 1; i >= 0; i--) {
            while (positions[right] - positions[i] > k) {
                right--;
            }
            current_max_wins_suffix = Math.max(current_max_wins_suffix, right - i + 1);
            max_segment_starting_at_or_after[i] = current_max_wins_suffix;
        }

        int overall_max_wins = 0;

        // Case 1: The two segments are chosen to be the same, or two identical segments.
        // In this case, we pick the single best segment twice.
        // The max_segment_ending_at_or_before[n-1] already holds the maximum wins from any single segment.
        overall_max_wins = max_segment_ending_at_or_before[n - 1] * 2;

        // Case 2: The two segments are strictly disjoint.
        // Iterate through all possible split points 'i'.
        // The first segment ends at or before positions[i], and the second segment starts at or after positions[i+1].
        for (int i = 0; i < n - 1; i++) {
            overall_max_wins = Math.max(overall_max_wins, 
                                        max_segment_ending_at_or_before[i] + max_segment_starting_at_or_after[i + 1]);
        }

        return overall_max_wins;
    }
}