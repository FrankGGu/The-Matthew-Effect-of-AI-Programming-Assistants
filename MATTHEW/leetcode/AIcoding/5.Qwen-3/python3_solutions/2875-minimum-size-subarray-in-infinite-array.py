class Solution:
    def minSubarray(self, nums: List[int], target: int) -> int:
        from collections import defaultdict

        n = len(nums)
        prefix = [0] * (n * 2)
        for i in range(n):
            prefix[i + n] = prefix[i] + nums[i]
            prefix[i] = prefix[i - 1] + nums[i - 1] if i > 0 else nums[0]

        map = defaultdict(int)
        map[0] = 0
        res = float('inf')

        for i in range(1, 2 * n):
            if prefix[i] - target in map:
                res = min(res, i - map[prefix[i] - target])
            map[prefix[i]] = min(map[prefix[i]], i)

        return res if res != float('inf') else -1