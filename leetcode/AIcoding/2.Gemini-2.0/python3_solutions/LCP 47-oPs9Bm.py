class Solution:
    def securityCheck(self, cap: list[int], spots: list[int]) -> int:
        cap.sort()
        spots.sort()
        count = 0
        i, j = 0, 0
        while i < len(cap) and j < len(spots):
            if cap[i] <= spots[j]:
                count += 1
                i += 1
                j += 1
            else:
                j += 1
        return count