class Solution:
    def maximizeHappiness(self, happiness: list[int], k: int) -> int:
        happiness.sort(reverse=True)
        total_happiness = 0
        for i in range(k):
            current_happiness = happiness[i] - i
            total_happiness += max(0, current_happiness)
        return total_happiness