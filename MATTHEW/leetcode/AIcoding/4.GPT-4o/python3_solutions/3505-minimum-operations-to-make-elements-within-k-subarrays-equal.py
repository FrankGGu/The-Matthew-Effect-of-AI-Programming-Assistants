class Solution:
    def minOperations(self, nums: List[int], k: int) -> int:
        from collections import defaultdict

        n = len(nums)
        min_ops = float('inf')
        count = defaultdict(int)

        for i in range(n):
            count[nums[i]] += 1
            if i >= k:
                count[nums[i - k]] -= 1
                if count[nums[i - k]] == 0:
                    del count[nums[i - k]]

            if i >= k - 1:
                total = sum(count.values())
                max_freq = max(count.values())
                min_ops = min(min_ops, total - max_freq)

        return min_ops if min_ops != float('inf') else 0