class Solution:
    def canSortArray(self, nums: list[int]) -> bool:
        def count_set_bits(n: int) -> int:
            return bin(n).count('1')

        n = len(nums)
        sorted_nums = sorted(nums)

        for i in range(n):
            if count_set_bits(nums[i]) != count_set_bits(sorted_nums[i]):
                return False

        return True