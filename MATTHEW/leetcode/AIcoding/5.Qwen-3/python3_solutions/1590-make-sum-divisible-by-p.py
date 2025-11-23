class Solution:
    def minSubarray(self, nums: List[int], p: int) -> int:
        total = sum(nums) % p
        if total == 0:
            return 0
        prefix_sum = 0
        last_indices = {0: -1}
        min_len = len(nums)
        for i, num in enumerate(nums):
            prefix_sum = (prefix_sum + num) % p
            target = (prefix_sum - total) % p
            if target in last_indices:
                min_len = min(min_len, i - last_indices[target])
            last_indices[prefix_sum] = i
        return min_len if min_len < len(nums) else -1