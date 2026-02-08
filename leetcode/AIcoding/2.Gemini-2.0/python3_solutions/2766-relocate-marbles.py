class Solution:
    def relocateMarbles(self, nums: list[int], moveFrom: list[int], moveTo: list[int]) -> list[int]:
        marble_positions = set(nums)
        for i in range(len(moveFrom)):
            if moveFrom[i] in marble_positions:
                marble_positions.remove(moveFrom[i])
                marble_positions.add(moveTo[i])
        return sorted(list(marble_positions))