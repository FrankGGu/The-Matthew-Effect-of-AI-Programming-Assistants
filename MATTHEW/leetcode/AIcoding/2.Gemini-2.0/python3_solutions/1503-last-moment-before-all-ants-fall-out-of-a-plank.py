class Solution:
    def getLastMoment(self, n: int, left: list[int], right: list[int]) -> int:
        max_left = 0
        for pos in left:
            max_left = max(max_left, pos)

        min_right = n
        for pos in right:
            min_right = min(min_right, pos)

        return max(max_left, n - min_right)