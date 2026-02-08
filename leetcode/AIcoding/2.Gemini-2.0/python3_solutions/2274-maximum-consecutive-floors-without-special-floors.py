class Solution:
    def maxConsecutive(self, bottom: int, top: int, special: List[int]) -> int:
        special.sort()
        max_consecutive = max(special[0] - bottom, top - special[-1])
        for i in range(len(special) - 1):
            max_consecutive = max(max_consecutive, special[i + 1] - special[i] - 1)
        return max_consecutive