class Solution:
    def canCross(self, stones: list[int]) -> bool:
        if stones[1] != 1:
            return False

        # dp[stone_position] stores a set of possible jump sizes to reach that stone
        dp = {stone: set() for stone in stones}

        # Initial state: at stone 0, with a dummy jump of 0
        dp[0].add(0)

        # For O(1) lookup of stone positions
        stone_positions = set(stones)

        # Iterate through each stone
        for current_stone in stones:
            # For each possible last_jump_size used to reach current_stone
            for last_jump_size in dp[current_stone]:
                # Try the three possible next jump sizes
                for next_jump_size in [last_jump_size - 1, last_jump_size, last_jump_size + 1]:
                    # Jump size must be positive
                    if next_jump_size > 0:
                        next_stone_pos = current_stone + next_jump_size

                        # If the next stone exists in the list of stones
                        if next_stone_pos in stone_positions:
                            # Add the next_jump_size to the set of jumps for next_stone_pos
                            dp[next_stone_pos].add(next_jump_size)

        # If the set of jump sizes for the last stone is not empty, it means it's reachable
        return len(dp[stones[-1]]) > 0