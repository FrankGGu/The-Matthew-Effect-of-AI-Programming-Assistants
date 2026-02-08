import java.util.*;

class Solution {
    public int minimumJumps(int[] forbidden, int a, int b, int x) {
        final int MAX_POS = 6000; 

        boolean[][] visited = new boolean[MAX_POS + 1][2];
        Set<Integer> forbiddenSet = new HashSet<>();
        for (int pos : forbidden) {
            forbiddenSet.add(pos);
        }

        Queue<int[]> queue = new LinkedList<>();

        // Queue stores {current_position, last_move_was_backward_flag, jumps}
        // last_move_was_backward_flag: 0 for forward, 1 for backward
        // Initial state: start at 0, no previous backward jump (represented by 0), 0 jumps
        queue.offer(new int[]{0, 0, 0}); 
        visited[0][0] = true; // Mark (0, lastJumpWasForward) as visited

        while (!queue.isEmpty()) {
            int[] curr = queue.poll();
            int currPos = curr[0];
            int lastJumpWasBackward = curr[1]; 
            int jumps = curr[2];

            if (currPos == x) {
                return jumps;
            }

            // Try forward jump (currPos + a)
            int nextPosForward = currPos + a;
            // Conditions for a valid forward jump:
            // 1. nextPosForward must be within bounds (0 to MAX_POS)
            // 2. nextPosForward must not be a forbidden position
            // 3. The state (nextPosForward, lastJumpWasForward) must not have been visited
            if (nextPosForward <= MAX_POS && !forbiddenSet.contains(nextPosForward) && !visited[nextPosForward][0]) {
                visited[nextPosForward][0] = true;
                queue.offer(new int[]{nextPosForward, 0, jumps + 1});
            }

            // Try backward jump (currPos - b)
            // Conditions for a valid backward jump:
            // 1. lastJumpWasBackward must be 0 (cannot jump backward twice in a row)
            // 2. nextPosBackward must be non-negative (>= 0)
            // 3. nextPosBackward must not be a forbidden position
            // 4. The state (nextPosBackward, lastJumpWasBackward) must not have been visited
            if (lastJumpWasBackward == 0) { // Can only jump backward if last jump was forward
                int nextPosBackward = currPos - b;
                if (nextPosBackward >= 0 && !forbiddenSet.contains(nextPosBackward) && !visited[nextPosBackward][1]) {
                    visited[nextPosBackward][1] = true;
                    queue.offer(new int[]{nextPosBackward, 1, jumps + 1});
                }
            }
        }

        return -1; // If x is unreachable
    }
}