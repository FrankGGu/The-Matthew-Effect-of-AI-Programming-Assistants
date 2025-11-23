import java.util.*;

class Solution {
    public int maxCandies(int[] status, int[] candies, int[][] keys, int[][] containedBoxes, int[] initialBoxes) {
        int n = status.length;
        long totalCandies = 0;

        // Tracks if we possess a key for a specific box.
        boolean[] hasKey = new boolean[n];
        // Tracks if we currently possess a box (either initially or found inside another box).
        boolean[] hasBox = new boolean[n];
        // Tracks if a box has already been opened.
        boolean[] opened = new boolean[n];

        // Queue for boxes that are currently openable and have not yet been opened.
        Queue<Integer> q = new LinkedList<>();

        // Initialize `hasBox` based on `initialBoxes`.
        for (int boxIdx : initialBoxes) {
            hasBox[boxIdx] = true;
        }

        // The main loop continues as long as there are changes that might lead to opening more boxes.
        // A change can be finding a new key or a new box.
        boolean changed = true;
        while (changed) {
            changed = false;

            // Phase 1: Identify all boxes we possess but haven't opened yet,
            // and check if they are now openable.
            for (int i = 0; i < n; i++) {
                if (hasBox[i] && !opened[i]) {
                    // A box is openable if its status is 1 (initially open) OR we have its key.
                    if (status[i] == 1 || hasKey[i]) {
                        q.offer(i);
                        opened[i] = true;
                        changed = true; // A new box was opened, so we might find more stuff.
                    }
                }
            }

            // Phase 2: Process all boxes that were added to the queue in Phase 1
            // (or from previous iterations if `changed` was true).
            while (!q.isEmpty()) {
                int currentBox = q.poll();
                totalCandies += candies[currentBox];

                // Collect keys found in the current box.
                for (int keyIdx : keys[currentBox]) {
                    if (!hasKey[keyIdx]) {
                        hasKey[keyIdx] = true;
                        changed = true; // Found a new key, which might unlock other boxes.
                    }
                }

                // Collect boxes found inside the current box.
                for (int containedBoxIdx : containedBoxes[currentBox]) {
                    if (!hasBox[containedBoxIdx]) {
                        hasBox[containedBoxIdx] = true;
                        changed = true; // Found a new box, which might be openable.
                    }
                }
            }
        }

        return (int) totalCandies;
    }
}