class Solution:
    def numberOfGoodPartitions(self, nums: List[int]) -> int:
        last_occurrence = {}
        for idx, num in enumerate(nums):
            last_occurrence[num] = idx

        max_reach = 0
        partitions = 0

        for idx, num in enumerate(nums):
            max_reach = max(max_reach, last_occurrence[num])
            if idx == max_reach:
                partitions += 1

        return (2 ** (partitions - 1)) % (10**9 + 7)