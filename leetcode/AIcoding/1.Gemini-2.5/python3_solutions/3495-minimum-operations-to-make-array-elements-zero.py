class Solution:
    def minimumOperations(self, nums: list[int]) -> int:
        distinct_positives = set()

        for num in nums:
            if num > 0:
                distinct_positives.add(num)

        return len(distinct_positives)