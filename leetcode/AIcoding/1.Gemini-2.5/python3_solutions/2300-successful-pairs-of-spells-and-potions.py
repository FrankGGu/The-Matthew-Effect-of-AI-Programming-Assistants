import bisect

class Solution:
    def successfulPairs(self, spells: list[int], potions: list[int], success: int) -> list[int]:
        potions.sort()
        n = len(spells)
        m = len(potions)
        result = [0] * n

        for i in range(n):
            spell_strength = spells[i]

            min_potion_strength = (success + spell_strength - 1) // spell_strength

            idx = bisect.bisect_left(potions, min_potion_strength)

            result[i] = m - idx

        return result