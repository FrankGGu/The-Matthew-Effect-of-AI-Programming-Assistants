class Solution:
    def findScore(self, nums: List[int]) -> int:
        n = len(nums)
        marked = [False] * n
        score = 0

        indexed_nums = sorted(enumerate(nums), key=lambda x: x[1])

        for index, value in indexed_nums:
            if not marked[index]:
                score += value
                marked[index] = True
                if index > 0:
                    marked[index - 1] = True
                if index < n - 1:
                    marked[index + 1] = True

        return score