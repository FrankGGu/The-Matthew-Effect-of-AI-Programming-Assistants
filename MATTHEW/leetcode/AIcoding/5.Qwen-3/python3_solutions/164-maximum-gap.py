class Solution:
    def maximumGap(self, nums: List[int]) -> int:
        if len(nums) < 2:
            return 0

        min_num = min(nums)
        max_num = max(nums)
        n = len(nums)

        bucket_size = (max_num - min_num) / (n - 1)
        buckets = [[] for _ in range(n)]

        for num in nums:
            if num == max_num:
                buckets[-1].append(num)
            else:
                idx = int((num - min_num) // bucket_size)
                buckets[idx].append(num)

        max_gap = 0
        prev = min_num

        for bucket in buckets:
            if not bucket:
                continue
            current_min = min(bucket)
            current_max = max(bucket)
            max_gap = max(max_gap, current_min - prev)
            prev = current_max

        return max_gap