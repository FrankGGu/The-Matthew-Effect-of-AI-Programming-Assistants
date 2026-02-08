class Solution:
    def countBalls(self, lowLimit: int, highLimit: int) -> int:
        counts = {}
        for i in range(lowLimit, highLimit + 1):
            s = sum(int(c) for c in str(i))
            if s not in counts:
                counts[s] = 0
            counts[s] += 1
        return max(counts.values())