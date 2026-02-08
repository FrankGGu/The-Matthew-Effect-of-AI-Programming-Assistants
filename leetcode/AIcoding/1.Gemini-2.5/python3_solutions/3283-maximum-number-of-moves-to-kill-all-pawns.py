class Solution:
    def maximumMoves(self, nums: list[int]) -> int:
        n = len(nums)
        player_pos = -1
        for i in range(n):
            if nums[i] == 1:
                player_pos = i
                break

        left_kills = 0
        for i in range(player_pos - 1, -1, -1):
            if nums[i] == -1:
                left_kills += 1
            elif nums[i] == 0:
                break

        right_kills = 0
        for i in range(player_pos + 1, n):
            if nums[i] == -1:
                right_kills += 1
            elif nums[i] == 0:
                break

        return max(left_kills, right_kills)