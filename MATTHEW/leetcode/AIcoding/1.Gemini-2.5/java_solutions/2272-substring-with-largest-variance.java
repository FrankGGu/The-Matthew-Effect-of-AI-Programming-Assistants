import java.util.HashSet;
import java.util.Set;

class Solution {
    public int largestVariance(String s) {
        int maxVariance = 0;
        Set<Character> distinctChars = new HashSet<>();
        for (char c : s.toCharArray()) {
            distinctChars.add(c);
        }

        for (char char1 : distinctChars) {
            for (char char2 : distinctChars) {
                if (char1 == char2) {
                    continue;
                }

                // currentDiff tracks count(char1) - count(char2) for the current segment.
                // currentDiffWithOneChar2Removed tracks count(char1) - count(char2) for a segment
                // where the first occurrence of char2 is effectively "removed" (its -1 contribution is cancelled out by +1).
                // This ensures that char2 is present at least once in the considered substring.
                int currentDiff = 0;
                int currentDiffWithOneChar2Removed = Integer.MIN_VALUE; // Use MIN_VALUE to signify no char2 seen yet or segment reset
                boolean foundChar2 = false; // Flag to indicate if char2 has been seen in the current segment

                for (char c : s.toCharArray()) {
                    if (c == char1) {
                        currentDiff++;
                        if (currentDiffWithOneChar2Removed != Integer.MIN_VALUE) {
                            currentDiffWithOneChar2Removed++;
                        }
                    } else if (c == char2) {
                        // When char2 is encountered:
                        // 1. Update currentDiffWithOneChar2Removed:
                        //    It can either extend the existing sequence (currentDiffWithOneChar2Removed - 1)
                        //    OR start a new sequence where this char2 is the first one.
                        //    If it's the first char2, its -1 contribution to currentDiff is cancelled by adding +1.
                        //    So, the value for starting a new segment is currentDiff_before_this_char2 + 1.
                        //    currentDiff_before_this_char2 is (currentDiff + 1) from the previous step.
                        //    So, currentDiff_before_this_char2 + 1 = (currentDiff + 1) + 1 = currentDiff + 2.
                        //    However, currentDiff here is already updated by this char2 (currentDiff--).
                        //    So, currentDiff_old + 1 is the correct value.
                        //    currentDiff_old is what currentDiff was before processing this char2.
                        //    If we use the current 'currentDiff' (which has already been decremented by 1 for this char2),
                        //    then currentDiff + 1 effectively means currentDiff_old.
                        //    So, max(currentDiffWithOneChar2Removed - 1, currentDiff + 1) is the correct logic.
                        if (currentDiffWithOneChar2Removed != Integer.MIN_VALUE) {
                            currentDiffWithOneChar2Removed = Math.max(currentDiffWithOneChar2Removed - 1, currentDiff + 1);
                        } else {
                            // If currentDiffWithOneChar2Removed was MIN_VALUE, it means no char2 was "removed" yet.
                            // This char2 is the first one. So we start a new segment by "removing" it.
                            // The value is currentDiff_old + 1.
                            currentDiffWithOneChar2Removed = currentDiff + 1;
                        }
                        currentDiff--;
                        foundChar2 = true;
                    }

                    // Only update maxVariance if char2 has been found in the current segment
                    // and currentDiffWithOneChar2Removed is not its initial MIN_VALUE state.
                    if (foundChar2 && currentDiffWithOneChar2Removed != Integer.MIN_VALUE) {
                        maxVariance = Math.max(maxVariance, currentDiffWithOneChar2Removed);
                    }

                    // If currentDiff becomes negative, it means char2 is dominating too much.
                    // Reset to 0 to start a new potential substring.
                    // currentDiffWithOneChar2Removed and foundChar2 must also be reset for a fresh segment.
                    if (currentDiff < 0) {
                        currentDiff = 0;
                        currentDiffWithOneChar2Removed = Integer.MIN_VALUE;
                        foundChar2 = false;
                    }
                }
            }
        }
        return maxVariance;
    }
}