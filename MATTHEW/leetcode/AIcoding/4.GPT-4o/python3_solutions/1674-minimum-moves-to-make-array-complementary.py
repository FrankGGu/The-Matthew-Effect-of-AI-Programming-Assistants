class Solution:
    def minMoves(self, nums: List[int], limit: List[int]) -> int:
        n = len(nums)
        diff = [0] * (2 * n + 2)

        for i in range(n):
            l, r = min(nums[i], limit[i]), max(nums[i], limit[i])
            diff[2] += 2
            diff[l + 1] -= 1
            diff[r + 1] += 1
            diff[r + 2] -= 1

        moves = float('inf')
        current_moves = 0

        for i in range(2, 2 * n + 1):
            current_moves += diff[i]
            moves = min(moves, current_moves)

        return moves