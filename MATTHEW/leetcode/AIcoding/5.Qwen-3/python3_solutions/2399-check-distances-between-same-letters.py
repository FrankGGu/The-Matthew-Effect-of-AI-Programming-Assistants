class Solution:
    def checkDistances(self, s: str, distance: List[int]) -> bool:
        last = {}
        for i, c in enumerate(s):
            if c in last:
                if i - last[c] - 1 != distance[ord(c) - ord('a')]:
                    return False
            else:
                last[c] = i
        return True