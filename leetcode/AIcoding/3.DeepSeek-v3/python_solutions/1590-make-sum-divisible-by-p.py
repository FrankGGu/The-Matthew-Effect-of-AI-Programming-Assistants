class Solution:
    def minSubarray(self, nums: List[int], p: int) -> int:
        total = sum(nums)
        remainder = total % p
        if remainder == 0:
            return 0

        prefix = 0
        last_occurrence = {0: -1}
        min_len = float('inf')

        for i, num in enumerate(nums):
            prefix = (prefix + num) % p
            target = (prefix - remainder) % p
            if target in last_occurrence:
                min_len = min(min_len, i - last_occurrence[target])
            last_occurrence[prefix] = i

        return min_len if min_len < len(nums) else -1