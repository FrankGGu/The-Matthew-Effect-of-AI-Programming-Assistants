class Solution:
    def minSizeSubarray(self, nums: List[int], target: int) -> int:
        total = sum(nums)
        n = len(nums)
        k, rem = divmod(target, total)
        if rem == 0:
            return k * n

        res = float('inf')
        prefix = {0: -1}
        current_sum = 0

        for i in range(2 * n):
            current_sum += nums[i % n]
            if (current_sum - rem) in prefix:
                res = min(res, i - prefix[current_sum - rem])
            prefix[current_sum] = i

        return res + k * n if res != float('inf') else -1