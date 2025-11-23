class Solution:
    def chalkReplacer(self, chalks: List[int], k: int) -> int:
        total = sum(chalks)
        k %= total
        for i in range(len(chalks)):
            if k < chalks[i]:
                return i
            k -= chalks[i]