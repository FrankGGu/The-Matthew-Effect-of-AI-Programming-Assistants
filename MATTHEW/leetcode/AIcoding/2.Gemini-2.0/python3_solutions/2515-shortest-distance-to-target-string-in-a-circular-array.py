class Solution:
    def shortestDistance(self, words: List[str], target: str, start: int) -> int:
        n = len(words)
        min_dist = float('inf')

        for i in range(n):
            if words[i] == target:
                dist = min(abs(i - start), n - abs(i - start))
                min_dist = min(min_dist, dist)

        return min_dist