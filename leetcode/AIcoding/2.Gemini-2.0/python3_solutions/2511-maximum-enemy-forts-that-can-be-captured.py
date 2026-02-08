class Solution:
    def captureForts(self, forts: List[int]) -> int:
        n = len(forts)
        max_captured = 0
        last_fort = -1
        for i in range(n):
            if forts[i] != 0:
                if last_fort != -1 and forts[i] != forts[last_fort]:
                    captured = i - last_fort - 1
                    max_captured = max(max_captured, captured)
                last_fort = i
        return max_captured