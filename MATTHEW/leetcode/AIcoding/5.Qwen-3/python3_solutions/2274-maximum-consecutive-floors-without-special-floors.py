class Solution:
    def maxConsecutive(self, n: int, restrictions: List[int]) -> int:
        restrictions.sort()
        max_consec = 0
        prev = 0
        for r in restrictions:
            max_consec = max(max_consec, r - prev - 1)
            prev = r
        max_consec = max(max_consec, n - prev)
        return max_consec