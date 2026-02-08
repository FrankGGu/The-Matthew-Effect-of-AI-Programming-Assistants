class Solution:
    def numTimesAllBlue(self, flips: list[int]) -> int:
        max_so_far = 0
        count = 0
        for i, flip in enumerate(flips):
            max_so_far = max(max_so_far, flip)
            if max_so_far == i + 1:
                count += 1
        return count