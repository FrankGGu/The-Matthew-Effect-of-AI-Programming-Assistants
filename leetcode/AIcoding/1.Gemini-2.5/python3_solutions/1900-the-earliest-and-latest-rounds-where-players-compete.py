class Solution:
    def earliestAndLatest(self, n: int, firstPlayer: int, secondPlayer: int) -> list[int]:
        memo = {}

        def solve(k, p1, p2):
            # Ensure p1 < p2 for consistent memoization
            if p1 > p2:
                p1, p2 = p2, p1

            if (k, p1, p2) in memo:
                return memo[(k, p1, p2)]

            # Check if they meet in this round
            # In a round with k players, player i competes with k-i+1.
            # If p1 and p2 meet, their indices must sum to k+1.
            if p1 + p2 == k + 1:
                return (1, 1) # They meet in this round (1st round of this subproblem)

            min_rounds = float('inf')
            max_rounds = float('-inf')

            # Calculate the number of players in the next round
            next_k = (k + 1) // 2

            # Iterate over all possible new positions for firstPlayer (new_p1) and secondPlayer (new_p2).
            # The new positions depend on how many players from the segments before p1 and between p1 and p2 win their matches.
            #
            # Let 'l' be the number of winners from players with indices < p1.
            # These players are from 1 to p1-1. The number of matches involving these players is (p1-1)//2.
            # So, 'l' can range from 0 to (p1-1)//2.
            #
            # Let 'm' be the number of winners from players with indices > p1 and < p2.
            # These players are from p1+1 to p2-1. The number of matches involving these players is (p2-p1-1)//2.
            # So, 'm' can range from 0 to (p2-p1-1)//2.

            # The new position of firstPlayer (new_p1) will be 1 + l.
            # The new position of secondPlayer (new_p2) will be 1 + l + 1 + m.
            # (1 for firstPlayer itself, 1 for secondPlayer itself)

            # Iterate through all valid combinations of 'l' and 'm'
            for l in range((p1 - 1) // 2 + 1):
                for m in range((p2 - p1 - 1) // 2 + 1):
                    new_p1 = l + 1
                    new_p2 = l + 1 + m + 1

                    # If new_p1 and new_p2 are the same, it means they would meet in this sub-round.
                    # This case should be handled by the base case, but if due to renumbering logic
                    # they become same, it's an invalid state for recursion.
                    # Also, new_p1 must be less than new_p2.
                    if new_p1 >= new_p2:
                        continue

                    # Recursively call for the next round
                    res_min, res_max = solve(next_k, new_p1, new_p2)

                    # Update overall min and max rounds
                    min_rounds = min(min_rounds, 1 + res_min)
                    max_rounds = max(max_rounds, 1 + res_max)

            memo[(k, p1, p2)] = (min_rounds, max_rounds)
            return (min_rounds, max_rounds)

        return solve(n, firstPlayer, secondPlayer)