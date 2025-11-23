import java.util.Arrays;

class Solution {
    public int getMaxRepetitions(String s1, int n1, String s2, int n2) {
        if (n1 == 0) {
            return 0;
        }

        int s1Len = s1.length();
        int s2Len = s2.length();

        // s2_rep_counts[i] stores the number of s2 repetitions found after i repetitions of s1.
        // s2_next_idx[i] stores the index in s2 where the matching process left off after i repetitions of s1.
        // These arrays store history up to s2Len + 1 states to detect a cycle.
        // Use long for counts as they can exceed Integer.MAX_VALUE.
        long[] s2_rep_counts = new long[s2Len + 1];
        int[] s2_next_idx = new int[s2Len + 1];

        // idx_map[s2_char_idx] stores the s1_rep_count when s2_char_idx was first encountered.
        // Initialize with -1 to indicate not seen.
        int[] idx_map = new int[s2Len + 1];
        Arrays.fill(idx_map, -1);

        long currentS2Count = 0; // Total s2 repetitions matched so far
        int currentS2Idx = 0;   // Current index in s2

        // Loop for s1_rep_count from 0 to n1.
        // 'i' represents the number of s1 repetitions processed so far.
        // The loop will run at most s2Len + 1 times before a cycle is guaranteed to be detected.
        for (int i = 0; i <= n1; i++) {
            s2_rep_counts[i] = currentS2Count;
            s2_next_idx[i] = currentS2Idx;

            if (idx_map[currentS2Idx] != -1) { // Cycle detected
                int prevS1Rep = idx_map[currentS2Idx];
                long prevS2Count = s2_rep_counts[prevS1Rep];

                long cycleLenS1 = i - prevS1Rep;
                long cycleS2Count = currentS2Count - prevS2Count;

                // Calculate s2 repetitions from full cycles that fit into remaining n1
                long remainingS1ToProcess = n1 - i;
                long numFullCycles = remainingS1ToProcess / cycleLenS1;

                long totalS2Matched = currentS2Count + numFullCycles * cycleS2Count;

                // Calculate s2 repetitions from the partial cycle after full cycles
                long s1RepsAfterFullCycles = i + numFullCycles * cycleLenS1;
                long remainingS1ForPartialCycle = n1 - s1RepsAfterFullCycles;

                // Add s2 counts for the remaining partial cycle segment
                // The index prevS1Rep + remainingS1ForPartialCycle will be within [0, s2Len]
                totalS2Matched += (s2_rep_counts[prevS1Rep + (int)remainingS1ForPartialCycle] - prevS2Count);

                return (int)(totalS2Matched / n2);
            }

            // Mark current s2_idx as seen at s1_rep_count = i
            idx_map[currentS2Idx] = i;

            // Simulate one s1 repetition (if there are more s1 repetitions to process)
            if (i < n1) { 
                for (int j = 0; j < s1Len; j++) {
                    if (s1.charAt(j) == s2.charAt(currentS2Idx)) {
                        currentS2Idx++;
                        if (currentS2Idx == s2Len) {
                            currentS2Count++;
                            currentS2Idx = 0;
                        }
                    }
                }
            }
        }

        // This part is reached if n1 is small (<= s2Len) and no cycle is detected within n1 repetitions.
        return (int)(currentS2Count / n2);
    }
}