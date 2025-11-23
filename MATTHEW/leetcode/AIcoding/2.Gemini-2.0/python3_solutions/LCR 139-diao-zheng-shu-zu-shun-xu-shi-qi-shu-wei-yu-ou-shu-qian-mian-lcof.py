class Solution:
    def trainningPlan(self, actions: list[int], k: int) -> list[int]:
        n = len(actions)
        k %= n
        return actions[n - k:] + actions[:n - k]