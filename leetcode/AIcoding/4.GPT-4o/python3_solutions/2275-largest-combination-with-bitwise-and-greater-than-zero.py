class Solution:
    def largestCombination(self, candidates: List[int]) -> int:
        return max(bin(x).count('1') for x in candidates)