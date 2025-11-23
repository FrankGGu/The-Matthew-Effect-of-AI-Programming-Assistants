class Solution:
    def numberOfGoodPartitions(self, nums: list[int]) -> int:
        last_occurrence = {}
        for i, num in enumerate(nums):
            last_occurrence[num] = i

        max_reach = 0
        current_reach = 0
        partitions = 0
        for i, num in enumerate(nums):
            max_reach = max(max_reach, last_occurrence[num])
            if i == current_reach:
                partitions += 1
                current_reach = max_reach
            else:
                current_reach = max(current_reach, max_reach)

        if partitions == 0:
            return 0

        MOD = 10**9 + 7
        result = pow(2, partitions - 1, MOD)
        return result