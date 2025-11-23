class Solution:
    def maximumGroups(self, strength: List[int]) -> int:
        strength.sort()
        res = 0
        i = 0
        while i < len(strength):
            j = i
            while j < len(strength) and strength[j] == strength[i]:
                j += 1
            res += 1
            i = j
        return res