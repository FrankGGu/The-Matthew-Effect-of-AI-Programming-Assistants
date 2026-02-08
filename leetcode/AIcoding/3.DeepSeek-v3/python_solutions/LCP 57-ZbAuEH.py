class Solution:
    def maxHammerHits(self, hammer: List[int], mice: List[int]) -> int:
        mice.sort()
        hammer.sort()
        res = 0
        i = j = 0
        m, n = len(mice), len(hammer)
        while i < m and j < n:
            if hammer[j] >= mice[i]:
                res += 1
                i += 1
                j += 1
            else:
                j += 1
        return res