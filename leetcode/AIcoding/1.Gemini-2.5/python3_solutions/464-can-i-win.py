class Solution:
    def canIWin(self, maxChoosableInteger: int, desiredTotal: int) -> bool:
        if desiredTotal <= 0:
            return True

        # If the sum of all choosable integers is less than desiredTotal,
        # it's impossible for anyone to reach desiredTotal.
        total_sum_possible = maxChoosableInteger * (maxChoosableInteger + 1) // 2
        if total_sum_possible < desiredTotal:
            return False

        # Memoization dictionary: key is the bitmask representing chosen numbers,
        # value is a boolean indicating if the current player can win from this state.
        memo = {}

        # solve(mask, current_sum_chosen) returns True if the current player can win
        # given the numbers represented by 'mask' have already been chosen,
        # and 'current_sum_chosen' is their sum.
        def solve(mask: int, current_sum_chosen: int) -> bool:
            # If this state has been computed before, return the stored result.
            if mask in memo:
                return memo[mask]

            # Iterate through all possible numbers the current player can choose.
            for i in range(1, maxChoosableInteger + 1):
                # Check if 'i' has not been chosen yet (i.e., its bit is not set in mask).
                if not ((mask >> (i - 1)) & 1):
                    # If choosing 'i' makes the total sum reach or exceed desiredTotal,
                    # the current player wins immediately.
                    if current_sum_chosen + i >= desiredTotal:
                        memo[mask] = True
                        return True

                    # If choosing 'i' does not lead to an immediate win,
                    # recursively call solve for the next player.
                    # If the next player *cannot* win from the new state (mask with 'i' chosen,
                    # and sum increased by 'i'), then the current player wins.
                    if not solve(mask | (1 << (i - 1)), current_sum_chosen + i):
                        memo[mask] = True
                        return True

            # If no move leads to a win for the current player, they lose.
            memo[mask] = False
            return False

        # Start the game with no numbers chosen (mask = 0) and current sum of 0.
        return solve(0, 0)