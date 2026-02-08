class Solution:
    def maximumGap(self, nums: List[int]) -> int:
        if len(nums) < 2:
            return 0

        n = len(nums)
        min_val = min(nums)
        max_val = max(nums)

        if min_val == max_val:
            return 0

        bucket_size = max(1, (max_val - min_val) // (n - 1))
        bucket_count = (max_val - min_val) // bucket_size + 1

        buckets_min = [float('inf')] * bucket_count
        buckets_max = [float('-inf')] * bucket_count

        for num in nums:
            bucket_index = (num - min_val) // bucket_size
            buckets_min[bucket_index] = min(buckets_min[bucket_index], num)
            buckets_max[bucket_index] = max(buckets_max[bucket_index], num)

        max_gap = 0
        prev_max = buckets_max[0]
        for i in range(1, bucket_count):
            if buckets_min[i] == float('inf'):
                continue
            max_gap = max(max_gap, buckets_min[i] - prev_max)
            prev_max = buckets_max[i]

        return max_gap