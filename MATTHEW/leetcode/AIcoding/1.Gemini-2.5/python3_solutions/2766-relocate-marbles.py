from typing import List

class Solution:
    def relocateMarbles(self, nums: List[int], moveFrom: List[int], moveTo: List[int]) -> List[int]:
        marble_positions = set(nums)

        for i in range(len(moveFrom)):
            marble_positions.discard(moveFrom[i])
            marble_positions.add(moveTo[i])

        result = list(marble_positions)
        result.sort()

        return result