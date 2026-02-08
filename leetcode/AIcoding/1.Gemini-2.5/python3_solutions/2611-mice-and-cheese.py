class Solution:
    def miceAndCheese(self, reward1: list[int], reward2: list[int], k: int) -> int:
        n = len(reward1)
        diffs = [reward1[i] - reward2[i] for i in range(n)]
        diffs.sort(reverse=True)

        total_reward = sum(reward2)
        for i in range(k):
            total_reward += diffs[i]

        return total_reward