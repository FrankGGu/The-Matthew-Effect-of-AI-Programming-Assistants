class Solution:
    def maximumGap(self, nums: List[int]) -> int:
        if len(nums) < 2:
            return 0
        min_val, max_val = min(nums), max(nums)
        if min_val == max_val:
            return 0

        n = len(nums)
        bucket_size = max(1, (max_val - min_val) // (n - 1))
        bucket_count = (max_val - min_val) // bucket_size + 1

        buckets = [[float('inf'), float('-inf')] for _ in range(bucket_count)]

        for num in nums:
            bucket_index = (num - min_val) // bucket_size
            buckets[bucket_index][0] = min(buckets[bucket_index][0], num)
            buckets[bucket_index][1] = max(buckets[bucket_index][1], num)

        max_gap = 0
        prev_max = min_val

        for bucket in buckets:
            if bucket[0] == float('inf'):
                continue
            max_gap = max(max_gap, bucket[0] - prev_max)
            prev_max = bucket[1]

        return max_gap