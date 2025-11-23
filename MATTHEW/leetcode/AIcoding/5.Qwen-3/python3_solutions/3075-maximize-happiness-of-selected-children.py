class Solution:
    def maximumHappiness(self, happiness: List[int], k: int) -> int:
        happiness.sort(reverse=True)
        total = 0
        for i in range(k):
            if happiness[i] - i <= 0:
                break
            total += happiness[i] - i
        return total