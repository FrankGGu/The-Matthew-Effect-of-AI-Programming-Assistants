class Solution:
    def solve(self, nums: list[int], ban: list[int]) -> int:
        ban_set = set(ban)
        count = 0
        for num in nums:
            if num not in ban_set:
                count += 1
        return count