class Solution:
    def successfulPairs(self, spells: list[int], potions: list[int], success: int) -> list[int]:
        potions.sort()
        n = len(spells)
        m = len(potions)
        ans = []
        for spell in spells:
            l, r = 0, m - 1
            idx = m
            while l <= r:
                mid = (l + r) // 2
                if spell * potions[mid] >= success:
                    idx = mid
                    r = mid - 1
                else:
                    l = mid + 1
            ans.append(m - idx)
        return ans