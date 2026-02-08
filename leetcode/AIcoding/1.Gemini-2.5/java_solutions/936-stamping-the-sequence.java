import java.util.*;

class Solution {
    public int[] movesToStamp(String stamp, String target) {
        char[] S = stamp.toCharArray();
        char[] T = target.toCharArray();
        int N = T.length;
        int M = S.length;

        List<Integer> ans = new ArrayList<>();

        // mismatch_counts[i]: number of positions j (0 to M-1) where T[i+j] != S[j] AND T[i+j] != '?'
        // This is actually "number of positions j where T[i+j] is a non-'?' character AND T[i+j] != S[j]"
        // When T[i+j] becomes '?', it no longer contributes to mismatch_counts[i].
        // So, mismatch_counts[i] tracks how many characters in the window T[i...i+M-1]
        // are non-'?' and do not match the corresponding character in S.
        int[] mismatch_counts = new int[N - M + 1];

        // non_wild_counts[i]: number of positions j (0 to M-1) where T[i+j] != '?'
        // This tracks how many non-'?' characters are in the window T[i...i+M-1].
        int[] non_wild_counts = new int[N - M + 1];

        // Queue to store indices 'i' where T[i...i+M-1] can be "un-stamped" (i.e., replaced by '?')
        Queue<Integer> q = new LinkedList<>();
        // To avoid adding duplicate indices to the queue
        boolean[] inQueue = new boolean[N - M + 1];

        // Initialize mismatch_counts and non_wild_counts for all possible stamp positions
        for (int i = 0; i <= N - M; i++) {
            for (int j = 0; j < M; j++) {
                if (T[i + j] != S[j]) {
                    mismatch_counts[i]++;
                }
                // Initially, target string consists of lowercase English letters, so no '?'
                // Thus, non_wild_counts[i] will be M for all i initially.
                // We keep this check for robustness, though.
                if (T[i + j] != '?') {
                    non_wild_counts[i]++;
                }
            }
            // A window T[i...i+M-1] is a candidate for un-stamping if:
            // 1. There are no mismatches (all T[i+j] are either S[j] or '?').
            // 2. There is at least one non-'?' character (we must make progress).
            if (mismatch_counts[i] == 0 && non_wild_counts[i] > 0) {
                q.offer(i);
                inQueue[i] = true;
            }
        }

        int totalWildcards = 0; // Count of '?' characters in T

        while (!q.isEmpty()) {
            int currIdx = q.poll();
            inQueue[currIdx] = false; // Mark as processed
            ans.add(currIdx);

            // Turn T[currIdx...currIdx+M-1] into '?'s
            for (int k = 0; k < M; k++) {
                int charIdx = currIdx + k; // Absolute index in T
                if (T[charIdx] != '?') { // Only process if not already '?'
                    char originalChar = T[charIdx]; // Store current value before modification
                    T[charIdx] = '?';
                    totalWildcards++;

                    // This change (T[charIdx] becoming '?') affects all windows 'x' that contain charIdx.
                    // A window 'x' contains charIdx if x <= charIdx < x + M.
                    // This means x ranges from max(0, charIdx - M + 1) to min(N - M, charIdx).
                    for (int x = Math.max(0, charIdx - M + 1); x <= Math.min(N - M, charIdx); x++) {
                        // Update non_wild_counts for window 'x'
                        // T[charIdx] was a non-'?' char, now it's '?', so non_wild_counts[x] decreases.
                        non_wild_counts[x]--;

                        // Update mismatch_counts for window 'x'
                        // If originalChar was a mismatch for window 'x' (i.e., originalChar != S[charIdx - x]),
                        // then T[charIdx] was contributing to mismatch_counts[x].
                        // Now that T[charIdx] is '?', it no longer contributes, so mismatch_counts[x] decreases.
                        if (originalChar != S[charIdx - x]) {
                            mismatch_counts[x]--;
                        }

                        // If window 'x' now becomes a valid un-stamp position and hasn't been added to queue
                        if (mismatch_counts[x] == 0 && non_wild_counts[x] > 0 && !inQueue[x]) {
                            q.offer(x);
                            inQueue[x] = true;
                        }
                    }
                }
            }
        }

        // If not all characters in T became '?', then it's impossible to stamp the sequence.
        if (totalWildcards != N) {
            return new int[0];
        }

        // The 'ans' list contains indices in reverse order of stamping
        // (i.e., the last stamp applied is the first one we "un-stamped").
        // We need to reverse it to get the chronological order of application.
        Collections.reverse(ans);

        // Convert List<Integer> to int[]
        int[] result = new int[ans.size()];
        for (int i = 0; i < ans.size(); i++) {
            result[i] = ans.get(i);
        }
        return result;
    }
}