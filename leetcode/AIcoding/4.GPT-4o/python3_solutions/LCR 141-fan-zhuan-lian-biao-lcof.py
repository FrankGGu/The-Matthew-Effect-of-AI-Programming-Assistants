class Solution:
    def trainingPlan(self, n: int, m: int, x: int, gains: List[int], loss: List[int]) -> bool:
        curr = x
        for i in range(n):
            curr += gains[i]
            if curr < 0:
                return False
            curr -= loss[i]
            if curr < 0:
                return False
        return True