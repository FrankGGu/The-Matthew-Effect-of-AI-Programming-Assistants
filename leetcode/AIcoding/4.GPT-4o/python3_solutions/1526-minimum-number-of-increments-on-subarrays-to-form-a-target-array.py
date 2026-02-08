class Solution:
    def minIncrements(self, n: int, target: List[int]) -> int:
        total = 0
        max_val = 0

        for num in target:
            max_val = max(max_val, num)

        increment = 0
        for i in range(len(target)):
            increment += max_val - target[i]

        return increment