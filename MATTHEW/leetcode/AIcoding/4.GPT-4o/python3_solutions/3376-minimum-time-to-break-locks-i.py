class Solution:
    def minTimeToUnlock(self, locks: List[int]) -> int:
        return sum(locks) + len(locks) * 2 - 2