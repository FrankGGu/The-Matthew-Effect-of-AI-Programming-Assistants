import java.util.HashSet;
import java.util.Set;

class Solution {
    public int shortestSequence(int[] rolls, int k) {
        // 'ans' represents the length of the longest possible sequence [1, 2, ..., ans].
        // We are looking for the shortest impossible sequence, which will be [1, 2, ..., ans + 1].
        // So, the final answer will be 'ans + 1'.
        // Let's rephrase: 'ans' will be the count of full sets of {1, ..., k} we have completed.
        // Each time we complete a set {1, ..., k}, it means we can form the next number in the sequence.
        // For example, if we complete {1, ..., k} once, we can form [1, ..., k].
        // If we complete {1, ..., k} twice, we can form [1, ..., k, 1, ..., k] which means we can form [1, ..., k] and then start looking for the next sequence.
        // This is not quite the same as [1, 2, ..., x].

        // Let's use a simpler approach based on the standard interpretation of "subsequence":
        // We are looking for the smallest 'x' such that the sequence [1, 2, ..., x] cannot be formed
        // by picking elements from 'rolls' in increasing order of indices.
        // This means we want to find '1', then '2' after it, then '3' after that, and so on.

        int currentTarget = 1; // The next number we are trying to find in the sequence [1, 2, ..., x]

        for (int roll : rolls) {
            if (roll == currentTarget) {
                currentTarget++; // Found the current target, now look for the next number (currentTarget + 1)
                if (currentTarget == k + 1) {
                    // We have successfully formed the sequence [1, 2, ..., k].
                    // The shortest impossible sequence is [1, 2, ..., k, k+1].
                    // Its length is k + 1.
                    return k + 1;
                }
            }
        }

        // If the loop finishes, it means we could only form [1, 2, ..., currentTarget - 1].
        // The shortest impossible sequence is [1, 2, ..., currentTarget].
        // Its length is currentTarget.
        return currentTarget;
    }
}