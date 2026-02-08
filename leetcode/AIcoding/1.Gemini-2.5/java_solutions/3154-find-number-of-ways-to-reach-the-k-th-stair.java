import java.util.HashMap;
import java.util.Objects;
import java.util.Map;

class Solution {
    // Assuming MAX_JUMPS is a reasonable upper bound for the number of jumps.
    // For k up to 10^9, log2(10^9) is about 30.
    // If we only jump, ~30 jumps. If we jump and step back, it could be more.
    // A common value for such problems is around 30-60. Let's use 32.
    private static final int MAX_JUMPS = 32;

    // Max power 'j' for 2^j. 2^30 is approx 10^9. So j can go up to 30.
    private static final int MAX_JUMP_POWER = 30;

    private Map<State, Integer> memo;
    private int targetK;

    // State class for memoization
    private static class State {
        long currentStair;
        int jumpsTaken;
        boolean lastActionWasJump; // true if last move was a jump, false if it was a down move or initial

        State(long currentStair, int jumpsTaken, boolean lastActionWasJump) {
            this.currentStair = currentStair;
            this.jumpsTaken = jumpsTaken;
            this.lastActionWasJump = lastActionWasJump;
        }

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (o == null || getClass() != o.getClass()) return false;
            State state = (State) o;
            return currentStair == state.currentStair &&
                   jumpsTaken == state.jumpsTaken &&
                   lastActionWasJump == state.lastActionWasJump;
        }

        @Override
        public int hashCode() {
            return Objects.hash(currentStair, jumpsTaken, lastActionWasJump);
        }
    }

    public int waysToReachStair(int k) {
        targetK = k;
        memo = new HashMap<>();

        // Initial state: stair 0, 0 jumps, last action was NOT a jump (initial state).
        // The recursive function will explore moves from this state.
        return dfs(0, 0, false);
    }

    private int dfs(long currentStair, int jumpsTaken, boolean lastActionWasJump) {
        // Base case: If we reached the target stair, count this as one way.
        if (currentStair == targetK) {
            // We count this path and stop exploring further from this specific state for the purpose of reaching targetK.
            // If we were allowed to make more moves after reaching k and still count, the logic would be different.
            return 1;
        }

        // Pruning conditions:
        // 1. If too many jumps have been taken.
        if (jumpsTaken > MAX_JUMPS) {
            return 0;
        }
        // 2. If current stair is negative.
        if (currentStair < 0) {
            return 0;
        }
        // 3. If current stair is too far above targetK.
        //    If currentStair > targetK + 1:
        //    - If lastActionWasJump is false (just moved down or initial): We must jump. Jumping from currentStair (which is > targetK+1) will always take us further away from targetK. So, this path cannot reach targetK.
        //    - If lastActionWasJump is true (just jumped): We must move down to currentStair - 1. From currentStair - 1, lastActionWasJump becomes false. If currentStair - 1 is still > targetK, then we are in the previous case and must jump further away.
        //    Thus, if currentStair > targetK + 1, we can never reach targetK.
        if (currentStair > targetK + 1) {
            return 0;
        }

        // Memoization check
        State currentState = new State(currentStair, jumpsTaken, lastActionWasJump);
        if (memo.containsKey(currentState)) {
            return memo.get(currentState);
        }

        int ways = 0;

        // Rule 1: "If we are at stair i and just jumped, we can only step back to i-1."
        if (lastActionWasJump) {
            // Must move down (if possible)
            if (currentStair > 0) {
                ways += dfs(currentStair - 1, jumpsTaken, false);
            }
        }
        // Rule 2: "If we are at stair i and just stepped back, we can only jump to i + 2^j for the next jump."
        // This also applies to the initial state (where lastActionWasJump is false).
        else {
            // Must jump
            for (int j = 0; j <= MAX_JUMP_POWER; j++) {
                long nextStair = currentStair + (1L << j); // Use 1L for long shift
                ways += dfs(nextStair, jumpsTaken + 1, true);
            }
        }

        memo.put(currentState, ways);
        return ways;
    }
}