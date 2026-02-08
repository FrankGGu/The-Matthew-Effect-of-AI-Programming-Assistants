class Solution:
    def minSubarray(self, nums: List[int], p: int) -> int:
        need = sum(nums) % p
        if need == 0:
            return 0

        min_len = len(nums)
        curr_sum = 0
        seen = {0: -1}

        for i, num in enumerate(nums):
            curr_sum = (curr_sum + num) % p
            target = (curr_sum - need) % p

            if target in seen:
                min_len = min(min_len, i - seen[target])

            seen[curr_sum] = i

        return min_len if min_len < len(nums) else -1