class Solution:
    def maximumHappinessSum(self, happiness: List[int], k: int) -> int:
        happiness.sort(reverse=True)
        total = 0
        for i in range(k):
            current = happiness[i] - i
            if current <= 0:
                break
            total += current
        return total