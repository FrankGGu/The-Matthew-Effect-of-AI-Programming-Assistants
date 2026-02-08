class Solution:
    def findMinimumTime(self, potions: list[int], materials: list[int], healing: list[int]) -> int:
        def check(t: int) -> bool:
            num_materials = len(potions)
            for j in range(num_materials):
                required_for_j = potions[j]
                initial_j = materials[j]
                rate_j = healing[j]

                if required_for_j <= initial_j:
                    # We already have enough of this material, no time needed for it.
                    continue

                # Calculate the amount of this material we still need to produce.
                needed_to_produce = required_for_j - initial_j

                if rate_j == 0:
                    # Cannot produce this material, but we need it. Impossible.
                    return False

                # Calculate the time required to produce 'needed_to_produce' units
                # at 'rate_j'. Use ceiling division: (a + b - 1) // b.
                time_for_this_material = (needed_to_produce + rate_j - 1) // rate_j

                if time_for_this_material > t:
                    # We cannot produce enough of this material within the given time 't'.
                    return False

            # If we reached here, it means we can produce enough of all materials
            # within the given time 't'.
            return True

        # The minimum possible time is 0.
        low = 0

        # The maximum possible time.
        # Max requirement for a single material is typically 10^9.
        # Min healing rate (if not 0) is 1.
        # So, max time for a single material could be 10^9.
        # A safe upper bound for binary search is often 2 * 10^9 or 10^10.
        high = 2 * (10**9) 

        # Initialize answer with the maximum possible time.
        ans = high

        while low <= high:
            mid = low + (high - low) // 2
            if check(mid):
                # If it's possible to brew all potions in 'mid' time,
                # 'mid' is a potential answer. Try for less time.
                ans = mid
                high = mid - 1
            else:
                # If it's not possible in 'mid' time, we need more time.
                low = mid + 1

        return ans