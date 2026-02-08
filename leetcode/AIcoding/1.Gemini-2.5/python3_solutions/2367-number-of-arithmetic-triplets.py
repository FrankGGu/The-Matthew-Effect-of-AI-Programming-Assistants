class Solution:
    def arithmeticTriplets(self, nums: list[int], diff: int) -> int:
        count = 0
        num_set = set(nums)

        for num in nums:
            if (num + diff) in num_set and (num + 2 * diff) in num_set:
                count += 1

        return count