class Solution:
    def maximumReward(self, A: List[int], operations: List[List[int]]) -> int:
        n = len(A)
        reward = [0] * n
        for op in operations:
            l, r, x = op
            for i in range(l, r + 1):
                reward[i] += A[i] + x
        return max(reward)