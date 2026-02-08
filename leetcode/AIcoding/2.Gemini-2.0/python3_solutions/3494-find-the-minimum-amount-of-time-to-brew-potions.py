class Solution:
    def minPotionBrewingTime(self, potions: list[int], machines: int) -> int:
        potions.sort()
        l, r = 0, max(potions)
        while l < r:
            mid = (l + r) // 2
            count = 0
            for potion in potions:
                count += (mid + potion - 1) // potion
            if count <= machines:
                r = mid
            else:
                l = mid + 1
        return l