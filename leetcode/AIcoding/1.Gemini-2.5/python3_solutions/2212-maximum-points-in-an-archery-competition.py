class Solution:
    def maximumBobPoints(self, numArrows: int, aliceArrows: list[int]) -> list[int]:
        max_score = -1
        best_arrow_distribution = [0] * 12

        # Iterate through all possible subsets of sections Bob can win.
        # A bitmask represents which sections Bob tries to win.
        # If the i-th bit is set, Bob tries to win section i.
        # There are 2^12 possible subsets, which is small enough (4096).
        for mask in range(1 << 12):
            current_score = 0
            current_arrows_spent = 0
            current_distribution = [0] * 12

            # Calculate score and arrows spent for the current mask.
            # Sections range from 0 to 11.
            for i in range(11, -1, -1):
                if (mask >> i) & 1:  # If the i-th bit is set, Bob tries to win section i.
                    # To win section i, Bob needs aliceArrows[i] + 1 arrows.
                    # This is the minimum number of arrows required to win.
                    arrows_needed_for_i = aliceArrows[i] + 1
                    current_arrows_spent += arrows_needed_for_i
                    current_score += i
                    current_distribution[i] = arrows_needed_for_i
                else:  # Bob does not try to win section i.
                    current_distribution[i] = 0

            # Check if this combination of wins is possible with the given numArrows.
            if current_arrows_spent <= numArrows:
                # If this combination yields a higher score, update max_score and best_distribution.
                # If scores are equal, any distribution is fine, so we only update for strictly greater.
                if current_score > max_score:
                    max_score = current_score
                    # Make a copy of the current distribution to store it as the best.
                    best_arrow_distribution = list(current_distribution)

                    # Distribute remaining arrows to section 0.
                    # Section 0 gives 0 points, so placing excess arrows here
                    # ensures all numArrows are used without affecting the score.
                    remaining_arrows = numArrows - current_arrows_spent
                    best_arrow_distribution[0] += remaining_arrows

        return best_arrow_distribution