from typing import List

class Solution:
    def countCompleteDayPairs(self, hours: List[int]) -> int:
        count = 0
        remainder_counts = [0] * 24

        for h in hours:
            remainder = h % 24

            # The remainder needed to form a sum divisible by 24
            # If current remainder is `r`, we need `(24 - r) % 24`
            # For example, if r=5, we need 19. If r=0, we need 0.
            target_remainder = (24 - remainder) % 24

            # Add the count of previously seen 'target_remainder' to the total pairs
            count += remainder_counts[target_remainder]

            # Increment the count for the current remainder
            remainder_counts[remainder] += 1

        return count