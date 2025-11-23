class Solution:
    def smallestMissingValue(self, nums: List[int]) -> int:
        prefix_sum = 0
        seen = set()

        for num in nums:
            prefix_sum += num
            seen.add(prefix_sum)

        smallest_missing = 1
        while smallest_missing in seen:
            smallest_missing += 1

        return smallest_missing