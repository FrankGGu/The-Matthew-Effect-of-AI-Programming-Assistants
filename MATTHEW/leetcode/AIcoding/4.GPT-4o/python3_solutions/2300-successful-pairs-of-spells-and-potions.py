class Solution:
    def successfulPairs(self, spells: List[int], potions: List[int], success: int) -> List[int]:
        potions.sort()
        result = []
        n = len(potions)

        for spell in spells:
            target = success / spell
            left, right = 0, n

            while left < right:
                mid = (left + right) // 2
                if potions[mid] < target:
                    left = mid + 1
                else:
                    right = mid

            result.append(n - left)

        return result