class Solution:
    def waysToReachStair(self, k: int) -> int:
        MOD = 10**9 + 7

        # Maximum number of forward jumps to consider.
        # If k is large (10^9), log2(k) is about 30. We might need a few more jumps
        # to overshoot k and come back, or to take smaller jumps. 32 is a safe upper bound.
        MAX_F_JUMPS = 32 

        # Maximum number of backward jumps. Cannot exceed forward jumps.
        # Also limited by the maximum number of times we can take a backward jump (after each forward jump).
        MAX_B_JUMPS = 32 

        # Maximum power 'p' for a 2^p jump. 2^30 is approx 10^9. 2^31 is ~2*10^9.
        # Using 30 covers jumps up to 2^30.
        MAX_POWER = 30 

        # Memoization table: (mapped_stair_idx, f_count, b_count, last_was_back) -> ways
        # mapped_stair_idx is used to keep the state space small despite large 'k'.
        # 0 for stair 0.
        # 1 to (2 * MAX_B_JUMPS + 1) for stairs in the range [k - MAX_B_JUMPS, k + MAX_B_JUMPS].
        memo = {}

        # The offset_bias defines the window around 'k' that we consider relevant.
        # We can be at most 'offset_bias' steps away from 'k' (either ahead or behind)
        # and still potentially reach 'k' with the remaining allowed jumps.
        offset_bias = MAX_B_JUMPS 

        # Helper function to map an absolute stair position to a compact index for memoization.
        # This is crucial for handling large 'k'.
        def get_mapped_stair_idx(stair):
            if stair == 0:
                return 0
            # If the stair is within the relevant window around k, map it to an index.
            # The window is [k - offset_bias, k + offset_bias].
            if k - offset_bias <= stair <= k + offset_bias:
                # This maps the window to indices [1, 2 * offset_bias + 1].
                return stair - (k - offset_bias) + 1
            return -1 # Indicates an irrelevant stair that should be pruned.

        def dfs(current_stair, f_count, b_count, last_was_back):
            # Pruning conditions:
            # 1. Cannot go below stair 0.
            if current_stair < 0:
                return 0
            # 2. Exceeded maximum allowed forward jumps.
            if f_count > MAX_F_JUMPS:
                return 0
            # 3. Exceeded maximum allowed backward jumps.
            if b_count > MAX_B_JUMPS:
                return 0
            # 4. Cannot take more backward jumps than forward jumps.
            if b_count > f_count:
                return 0

            # Pruning based on distance from k:
            # 5. If current_stair is too far ahead to reach k even with all remaining backward jumps.
            #    (MAX_B_JUMPS - b_count) is the maximum number of backward jumps remaining.
            if current_stair > k + (MAX_B_JUMPS - b_count):
                return 0
            # 6. If current_stair is too far behind to reach k even with all remaining forward jumps.
            #    Assuming each remaining forward jump is 2^0 = 1.
            #    (MAX_F_JUMPS - f_count) is the maximum number of forward jumps remaining.
            if current_stair < k - (MAX_F_JUMPS - f_count):
                return 0

            # Map current_stair to its compact index. If it's outside the relevant window, prune.
            stair_idx = get_mapped_stair_idx(current_stair)
            if stair_idx == -1:
                return 0

            # Memoization check
            state = (stair_idx, f_count, b_count, last_was_back)
            if state in memo:
                return memo[state]

            ways = 0

            # Option 1: Take a forward jump (current_stair + 2^p)
            for p in range(MAX_POWER + 1): # Iterate through possible powers for the jump
                next_stair = current_stair + (1 << p)
                if next_stair == k:
                    # If we land exactly on k, this is one valid way to end a path.
                    ways = (ways + 1) % MOD
                else:
                    # Continue exploring from next_stair.
                    ways = (ways + dfs(next_stair, f_count + 1, b_count, False)) % MOD

            # Option 2: Take a backward jump (current_stair - 1)
            # This is only allowed if the last jump was NOT backward.
            if not last_was_back:
                next_stair = current_stair - 1
                if next_stair >= 0: # Cannot go below stair 0.
                    if next_stair == k:
                        # If we land exactly on k, this is one valid way to end a path.
                        ways = (ways + 1) % MOD
                    else:
                        # Continue exploring from next_stair.
                        ways = (ways + dfs(next_stair, f_count, b_count + 1, True)) % MOD

            # Store the result in memo and return.
            memo[state] = ways
            return ways

        # Start the Depth-First Search from stair 0.
        # Initial state: 0 forward jumps, 0 backward jumps, last action was not backward.
        return dfs(0, 0, 0, False)